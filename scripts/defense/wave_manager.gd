extends Node

signal wave_started(wave_number: int)
signal wave_cleared(wave_number: int)
signal all_waves_cleared()

var current_wave: int = 0
var total_waves: int = 3
var enemies_alive: int = 0
var _spawn_timer: float = 0.0
var _enemies_to_spawn: int = 0
var _spawn_interval: float = 1.5
var _spawning: bool = false
var _enemy_data: Resource = null

var enemies_container: Node2D = null

const EnemyScene = preload("res://scenes/defense/enemy.tscn")

func _ready() -> void:
	var game_state = get_node_or_null("/root/GameState")
	if game_state:
		game_state.phase_changed.connect(_on_phase_changed)

func set_container(container: Node2D) -> void:
	enemies_container = container

func _on_phase_changed(phase: int) -> void:
	if phase == 2:  # NIGHT
		current_wave = 0
		_start_next_wave()

func _start_next_wave() -> void:
	current_wave += 1
	if current_wave > total_waves:
		all_waves_cleared.emit()
		var game_state = get_node_or_null("/root/GameState")
		if game_state:
			game_state.start_dawn()
		return

	wave_started.emit(current_wave)
	_enemies_to_spawn = 3 + (current_wave * 2)
	_spawning = true
	_spawn_timer = 0.0

func _process(delta: float) -> void:
	if not _spawning:
		return
	_spawn_timer -= delta
	if _spawn_timer <= 0.0 and _enemies_to_spawn > 0:
		_spawn_enemy()
		_enemies_to_spawn -= 1
		_spawn_timer = _spawn_interval
		if _enemies_to_spawn <= 0:
			_spawning = false

func _spawn_enemy() -> void:
	if not enemies_container:
		return
	if not _enemy_data:
		_enemy_data = load("res://resources/enemies/zombie.tres")

	var enemy = EnemyScene.instantiate()
	enemies_container.add_child(enemy)
	enemy.setup(_enemy_data)

	# Spawn from random edge of farm (30*32=960 wide, 20*32=640 tall)
	var farm_w := 960.0
	var farm_h := 640.0
	var side: int = randi() % 4
	match side:
		0: enemy.global_position = Vector2(randf_range(0, farm_w), -20)
		1: enemy.global_position = Vector2(farm_w + 20, randf_range(0, farm_h))
		2: enemy.global_position = Vector2(randf_range(0, farm_w), farm_h + 20)
		3: enemy.global_position = Vector2(-20, randf_range(0, farm_h))

	enemy.died.connect(_on_enemy_died)
	enemies_alive += 1

func _on_enemy_died(enemy) -> void:
	enemies_alive -= 1
	if enemy.data:
		var res_mgr = get_node_or_null("/root/ResourceMgr")
		if res_mgr:
			res_mgr.add("gold", enemy.data.gold_drop)
	if enemies_alive <= 0 and not _spawning:
		wave_cleared.emit(current_wave)
		# Brief pause then next wave
		await get_tree().create_timer(3.0).timeout
		_start_next_wave()
