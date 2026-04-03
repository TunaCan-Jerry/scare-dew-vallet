extends TileMapLayer

## Manages the farm tile grid — soil states, crop placement.

signal tile_clicked(tile_pos: Vector2i)

# Soil states tracked separately from tilemap visual
# Key: Vector2i tile position, Value: Dictionary with state info
var soil_data: Dictionary = {}

# We'll use atlas coords to represent different tile types
# For now, use source_id=0 and different atlas coords:
const TILE_GRASS := Vector2i(0, 0)
const TILE_TILLED := Vector2i(1, 0)
const TILE_PLANTED := Vector2i(2, 0)
const TILE_PATH := Vector2i(3, 0)

func _ready() -> void:
	# Initialize the grid as grass
	for x in range(30):
		for y in range(20):
			set_cell(Vector2i(x, y), 0, TILE_GRASS)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos: Vector2 = get_local_mouse_position()
		var tile_pos: Vector2i = local_to_map(mouse_pos)
		tile_clicked.emit(tile_pos)

func till_soil(tile_pos: Vector2i) -> bool:
	# Can only till grass tiles within bounds
	if tile_pos.x < 0 or tile_pos.x >= 30 or tile_pos.y < 0 or tile_pos.y >= 20:
		return false
	if not soil_data.has(tile_pos):
		soil_data[tile_pos] = {"state": "tilled", "crop": "", "growth": 0, "watered": false}
		set_cell(tile_pos, 0, TILE_TILLED)
		return true
	return false

func plant_crop(tile_pos: Vector2i, crop_name: String) -> bool:
	if soil_data.has(tile_pos) and soil_data[tile_pos].state == "tilled":
		soil_data[tile_pos].state = "planted"
		soil_data[tile_pos].crop = crop_name
		soil_data[tile_pos].growth = 0
		set_cell(tile_pos, 0, TILE_PLANTED)
		return true
	return false

func water_tile(tile_pos: Vector2i) -> bool:
	if soil_data.has(tile_pos) and soil_data[tile_pos].state == "planted":
		soil_data[tile_pos]["watered"] = true
		return true
	return false

func advance_crops() -> Array:
	## Called at dawn. Grows watered crops. Returns list of harvestable positions.
	var harvestable: Array = []
	for pos in soil_data:
		var data: Dictionary = soil_data[pos]
		if data.state == "planted" and data.get("watered", false):
			data.growth += 1
			data.watered = false
			if data.growth >= 3:  # 3 days to harvest
				harvestable.append(pos)
	return harvestable

func harvest(tile_pos: Vector2i) -> String:
	if soil_data.has(tile_pos) and soil_data[tile_pos].state == "planted" and soil_data[tile_pos].growth >= 3:
		var crop_name: String = soil_data[tile_pos].crop
		soil_data[tile_pos] = {"state": "tilled", "crop": "", "growth": 0, "watered": false}
		set_cell(tile_pos, 0, TILE_TILLED)
		return crop_name
	return ""
