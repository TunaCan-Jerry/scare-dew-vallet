class_name BuildingData
extends Resource

# Building types as integers to avoid cross-file class_name issues
# WALL=0, TURRET=1, LIGHT=2, SHELTER=3, STATION=4
@export var building_name: String = ""
@export var building_type: int = 0
@export var description: String = ""
@export var max_health: int = 100
@export var size: Vector2i = Vector2i(1, 1)
@export var costs: Dictionary = {}
@export var color: Color = Color.GRAY
