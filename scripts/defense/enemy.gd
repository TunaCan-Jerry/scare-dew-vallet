extends CharacterBody2D

signal died(enemy: CharacterBody2D)

var data: Resource  # EnemyData
var current_health: int = 0
var _target: Node2D = null
var _attack_cooldown: float = 0.0

func setup(enemy_data) -> void:
	data = enemy_data
	current_health = data.max_health
	queue_redraw()

func set_target(target: Node2D) -> void:
	_target = target
	var nav = get_node_or_null("NavigationAgent2D")
	if nav and target:
		nav.target_position = target.global_position

func take_damage(amount: int) -> void:
	current_health -= amount
	queue_redraw()
	if current_health <= 0:
		died.emit(self)
		queue_free()

func _physics_process(delta: float) -> void:
	if not _target or not is_instance_valid(_target):
		# Find a new target - look for buildings
		_find_new_target()
		if not _target:
			return

	var nav = get_node_or_null("NavigationAgent2D")
	if nav:
		nav.target_position = _target.global_position
		if nav.is_navigation_finished():
			_try_attack(delta)
			return
		var next_pos: Vector2 = nav.get_next_path_position()
		var direction: Vector2 = (next_pos - global_position).normalized()
		velocity = direction * data.speed
	else:
		# Fallback: move directly toward target
		var direction: Vector2 = (_target.global_position - global_position).normalized()
		var dist: float = global_position.distance_to(_target.global_position)
		if dist < 20.0:
			_try_attack(delta)
			velocity = Vector2.ZERO
		else:
			velocity = direction * data.speed

	move_and_slide()

func _find_new_target() -> void:
	var buildings_node = get_node_or_null("/root/Game/Buildings")
	if not buildings_node:
		return
	var nearest_dist := 99999.0
	for child in buildings_node.get_children():
		if is_instance_valid(child):
			var dist: float = global_position.distance_to(child.global_position)
			if dist < nearest_dist:
				nearest_dist = dist
				_target = child

func _try_attack(delta: float) -> void:
	_attack_cooldown -= delta
	if _attack_cooldown <= 0.0:
		if _target and is_instance_valid(_target) and _target.has_method("take_damage"):
			_target.take_damage(data.damage)
		_attack_cooldown = 1.0 / data.attack_speed

func _draw() -> void:
	if data:
		draw_circle(Vector2.ZERO, 12.0, data.color)
		var hp_ratio: float = float(current_health) / float(data.max_health) if data.max_health > 0 else 0.0
		draw_rect(Rect2(-12, -18, 24, 3), Color.DARK_RED)
		draw_rect(Rect2(-12, -18, 24.0 * hp_ratio, 3), Color.RED)
