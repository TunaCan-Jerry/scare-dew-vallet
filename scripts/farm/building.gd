extends Node2D

## A placed building instance with health.

var data: Resource  # BuildingData
var current_health: int = 0
var tile_pos: Vector2i

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

func _draw() -> void:
	if data:
		var size_px: Vector2 = Vector2(data.size) * 32.0
		draw_rect(Rect2(-size_px / 2, size_px), data.color)
		# Health bar
		var bar_width: float = size_px.x
		var hp_ratio: float = float(current_health) / float(data.max_health) if data.max_health > 0 else 0.0
		draw_rect(Rect2(-bar_width / 2, -size_px.y / 2 - 6, bar_width, 4), Color.DARK_RED)
		draw_rect(Rect2(-bar_width / 2, -size_px.y / 2 - 6, bar_width * hp_ratio, 4), Color.GREEN)
