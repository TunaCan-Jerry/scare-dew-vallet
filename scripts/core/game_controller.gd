extends Node2D

## Main game controller. Creates and connects all systems.

# Node references (created in _ready)
var farm_grid: Node
var building_system: Node
var wave_manager: Node
var day_night_cycle: Node
var lighting: Node
var player: CharacterBody2D
var hud: Node
var build_menu: Node
var day_controller: Node
var dialogue_box: Node
var npc_maria: CharacterBody2D

var buildings_container: Node2D
var enemies_container: Node2D

func _ready() -> void:
	_create_scene_tree()
	_connect_signals()
	# Start the game
	var game_state = get_node("/root/GameState")
	game_state.start_day()

func _create_scene_tree() -> void:
	# Lighting (CanvasModulate - must be first to affect everything)
	lighting = CanvasModulate.new()
	lighting.name = "Lighting"
	lighting.set_script(load("res://scripts/core/lighting_manager.gd"))
	add_child(lighting)

	# Farm grid (TileMapLayer)
	farm_grid = TileMapLayer.new()
	farm_grid.name = "FarmGrid"
	farm_grid.set_script(load("res://scripts/farm/farm_grid.gd"))
	# Create a simple TileSet with colored tiles
	var tileset := TileSet.new()
	tileset.tile_size = Vector2i(32, 32)
	var source := TileSetAtlasSource.new()
	# Create a simple image for the tile atlas
	var img := Image.create(128, 32, false, Image.FORMAT_RGBA8)
	# Grass tile (0,0) - green
	for x in range(0, 32):
		for y in range(32):
			img.set_pixel(x, y, Color(0.25, 0.45, 0.2))
	# Tilled tile (1,0) - brown
	for x in range(32, 64):
		for y in range(32):
			img.set_pixel(x, y, Color(0.4, 0.28, 0.15))
	# Planted tile (2,0) - dark green with dots
	for x in range(64, 96):
		for y in range(32):
			var c := Color(0.3, 0.5, 0.25)
			if (x + y) % 8 == 0:
				c = Color(0.2, 0.6, 0.2)
			img.set_pixel(x, y, c)
	# Path tile (3,0) - tan
	for x in range(96, 128):
		for y in range(32):
			img.set_pixel(x, y, Color(0.6, 0.55, 0.4))
	var tex := ImageTexture.create_from_image(img)
	source.texture = tex
	source.texture_region_size = Vector2i(32, 32)
	# Create tile entries
	source.create_tile(Vector2i(0, 0))  # grass
	source.create_tile(Vector2i(1, 0))  # tilled
	source.create_tile(Vector2i(2, 0))  # planted
	source.create_tile(Vector2i(3, 0))  # path
	tileset.add_source(source, 0)
	farm_grid.tile_set = tileset
	add_child(farm_grid)

	# Buildings container
	buildings_container = Node2D.new()
	buildings_container.name = "Buildings"
	add_child(buildings_container)

	# Building system
	building_system = Node.new()
	building_system.name = "BuildingSystem"
	building_system.set_script(load("res://scripts/farm/building_system.gd"))
	add_child(building_system)
	building_system.set_container(buildings_container)

	# Enemies container
	enemies_container = Node2D.new()
	enemies_container.name = "Enemies"
	add_child(enemies_container)

	# Wave manager
	wave_manager = Node.new()
	wave_manager.name = "WaveManager"
	wave_manager.set_script(load("res://scripts/defense/wave_manager.gd"))
	add_child(wave_manager)
	wave_manager.set_container(enemies_container)

	# Day/Night cycle
	day_night_cycle = Node.new()
	day_night_cycle.name = "DayNightCycle"
	day_night_cycle.set_script(load("res://scripts/core/day_night_cycle.gd"))
	add_child(day_night_cycle)

	# Player commander
	player = CharacterBody2D.new()
	player.name = "PlayerCommander"
	player.set_script(load("res://scripts/core/player_commander.gd"))
	var player_collision := CollisionShape2D.new()
	var player_shape := CircleShape2D.new()
	player_shape.radius = 10.0
	player_collision.shape = player_shape
	player.add_child(player_collision)
	player.position = Vector2(480, 320)  # Center of farm
	add_child(player)

	# Camera following player
	var camera := Camera2D.new()
	camera.name = "Camera"
	camera.zoom = Vector2(1.5, 1.5)
	camera.position_smoothing_enabled = true
	camera.position_smoothing_speed = 5.0
	player.add_child(camera)

	# NPC Maria
	var maria_data = load("res://resources/characters/maria.tres")
	npc_maria = CharacterBody2D.new()
	npc_maria.name = "Maria"
	npc_maria.set_script(load("res://scripts/characters/npc.gd"))
	var maria_collision := CollisionShape2D.new()
	var maria_shape := CircleShape2D.new()
	maria_shape.radius = 10.0
	maria_collision.shape = maria_shape
	npc_maria.add_child(maria_collision)
	npc_maria.position = Vector2(350, 280)
	add_child(npc_maria)
	npc_maria.setup(maria_data)

	# HUD (extends CanvasLayer)
	hud = CanvasLayer.new()
	hud.name = "HUD"
	hud.set_script(load("res://scripts/ui/hud.gd"))
	add_child(hud)

	# Build menu (as CanvasLayer child)
	var build_menu_layer := CanvasLayer.new()
	build_menu_layer.name = "BuildMenuLayer"
	add_child(build_menu_layer)
	build_menu = PanelContainer.new()
	build_menu.name = "BuildMenu"
	build_menu.set_script(load("res://scripts/ui/build_menu.gd"))
	build_menu_layer.add_child(build_menu)

	# Dialogue box (extends CanvasLayer)
	dialogue_box = CanvasLayer.new()
	dialogue_box.name = "DialogueBox"
	dialogue_box.set_script(load("res://scripts/ui/dialogue_box.gd"))
	add_child(dialogue_box)

	# Day controller
	day_controller = Node.new()
	day_controller.name = "DayController"
	day_controller.set_script(load("res://scripts/farm/day_controller.gd"))
	add_child(day_controller)
	day_controller.setup(farm_grid, building_system, build_menu)

func _connect_signals() -> void:
	var game_state = get_node("/root/GameState")
	game_state.phase_changed.connect(_on_phase_changed)

	if wave_manager.has_signal("wave_started"):
		wave_manager.wave_started.connect(_on_wave_started)
	if wave_manager.has_signal("wave_cleared"):
		wave_manager.wave_cleared.connect(_on_wave_cleared)
	if wave_manager.has_signal("all_waves_cleared"):
		wave_manager.all_waves_cleared.connect(_on_all_waves_cleared)

func _on_phase_changed(phase: int) -> void:
	if phase == 3:  # DAWN
		_process_dawn()

func _process_dawn() -> void:
	# Advance crops
	if farm_grid and farm_grid.has_method("advance_crops"):
		var harvestable: Array = farm_grid.advance_crops()

	# Consume food
	var res_mgr = get_node("/root/ResourceMgr")
	res_mgr.spend("food", 1)

	# Salvage from night
	res_mgr.add("scrap", 3)

func _on_wave_started(wave_num: int) -> void:
	if hud and hud.has_method("show_wave"):
		hud.show_wave(wave_num)

func _on_wave_cleared(wave_num: int) -> void:
	if hud and hud.has_method("show_wave_cleared"):
		hud.show_wave_cleared(wave_num)

func _on_all_waves_cleared() -> void:
	pass

# NPC interaction - check Tab key press near NPCs
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_text_indent"):  # Tab key as interact
		_try_interact_with_npc()

func _try_interact_with_npc() -> void:
	if not player or not npc_maria:
		return
	if dialogue_box and dialogue_box.has_method("is_showing") and dialogue_box.is_showing():
		return
	var dist: float = player.global_position.distance_to(npc_maria.global_position)
	if dist < 50.0:
		var text: String = npc_maria.interact()
		var char_name: String = npc_maria.get_display_name()
		if dialogue_box and dialogue_box.has_method("show_dialogue"):
			dialogue_box.show_dialogue(char_name, text)
