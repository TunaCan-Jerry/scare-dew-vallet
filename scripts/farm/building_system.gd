extends Node

## Manages building placement, tracks all buildings on the grid.

signal building_placed(building: Node2D, pos: Vector2i)
signal building_destroyed(building: Node2D, pos: Vector2i)

const BuildingScript = preload("res://scripts/farm/building.gd")
const TurretScript = preload("res://scripts/defense/turret.gd")

var buildings: Dictionary = {}  # Vector2i -> Node2D (Building)
var buildings_container: Node2D = null

func _ready() -> void:
	# Will be set when game scene is ready
	pass

func set_container(container: Node2D) -> void:
	buildings_container = container

func can_place(pos: Vector2i, data) -> bool:
	for x in range(data.size.x):
		for y in range(data.size.y):
			var check_pos := Vector2i(pos.x + x, pos.y + y)
			if buildings.has(check_pos):
				return false
	var res_mgr = get_node_or_null("/root/ResourceMgr")
	if res_mgr:
		return res_mgr.can_afford(data.costs)
	return true

func place_building(pos: Vector2i, data) -> bool:
	if not buildings_container:
		return false
	if not can_place(pos, data):
		return false

	var res_mgr = get_node_or_null("/root/ResourceMgr")
	if res_mgr and not res_mgr.spend_multiple(data.costs):
		return false

	var building_node := Node2D.new()
	if data.building_type == 1:
		building_node.set_script(TurretScript)
	else:
		building_node.set_script(BuildingScript)
	buildings_container.add_child(building_node)
	building_node.setup(data, pos)

	for x in range(data.size.x):
		for y in range(data.size.y):
			buildings[Vector2i(pos.x + x, pos.y + y)] = building_node

	building_placed.emit(building_node, pos)
	return true

func get_building_at(pos: Vector2i):
	return buildings.get(pos, null)

func get_all_buildings() -> Array:
	var unique: Array = []
	for bld in buildings.values():
		if bld not in unique and is_instance_valid(bld):
			unique.append(bld)
	return unique

func remove_building(pos: Vector2i) -> void:
	var building = buildings.get(pos)
	if building:
		for key in buildings.keys():
			if buildings[key] == building:
				buildings.erase(key)
		building_destroyed.emit(building, pos)
		building.queue_free()
