extends Node2D

## A turret that auto-fires at enemies during night phase.

var data: Resource  # BuildingData
var current_health: int = 0
var tile_pos: Vector2i

var fire_range: float = 150.0
var fire_rate: float = 2.0
var bullet_damage: int = 10
var _fire_cooldown: float = 0.0
var _target: Node2D = null

func setup(building_data, pos: Vector2i) -> void:
	data = building_data
	current_health = data.max_health
	tile_pos = pos
	position = Vector2(pos.x * 32 + 16, pos.y * 32 + 16)
	queue_redraw()

func take_damage(amount: int) -> void:
	current_health = maxi(current_health - amount, 0)
	queue_redraw()
	if current_health <= 0:
		queue_free()

func repair(amount: int) -> void:
	current_health = mini(current_health + amount, data.max_health)
	queue_redraw()

func _process(delta: float) -> void:
	var game_state = get_node_or_null("/root/GameState")
	if not game_state or game_state.current_phase != 2:  # NIGHT = 2
		return

	_fire_cooldown -= delta
	if _fire_cooldown <= 0.0:
		_find_target()
		if _target and is_instance_valid(_target):
			_fire()
			_fire_cooldown = 1.0 / fire_rate

func _find_target() -> void:
	_target = null
	var enemies_node = get_node_or_null("/root/Game/Enemies")
	if not enemies_node:
		return
	var nearest_dist := fire_range
	for enemy in enemies_node.get_children():
		if not is_instance_valid(enemy):
			continue
		var dist: float = global_position.distance_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			_target = enemy

func _fire() -> void:
	if _target and _target.has_method("take_damage"):
		_target.take_damage(bullet_damage)
	queue_redraw()

func _draw() -> void:
	if not data:
		return
	# Turret body
	draw_rect(Rect2(-14, -14, 28, 28), data.color)
	# Gun barrel - point toward target
	var barrel_dir := Vector2.UP
	if _target and is_instance_valid(_target):
		barrel_dir = (_target.global_position - global_position).normalized()
	draw_line(Vector2.ZERO, barrel_dir * 18.0, Color.WHITE, 2.0)
	# Range circle at night
	var game_state = get_node_or_null("/root/GameState")
	if game_state and game_state.current_phase == 2:
		draw_arc(Vector2.ZERO, fire_range, 0, TAU, 32, Color(1, 1, 1, 0.1), 1.0)
	# HP bar
	var hp_ratio: float = float(current_health) / float(data.max_health) if data.max_health > 0 else 0.0
	draw_rect(Rect2(-14, -20, 28, 3), Color.DARK_RED)
	draw_rect(Rect2(-14, -20, 28.0 * hp_ratio, 3), Color.GREEN)
