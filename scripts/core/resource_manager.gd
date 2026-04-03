class_name ResourceManager
extends Node

signal resource_changed(resource_name: String, new_amount: int)

var _resources: Dictionary = {
	"gold": 100,
	"food": 20,
	"scrap": 10,
}

func get_amount(resource_name: String) -> int:
	return _resources.get(resource_name, 0)

func add(resource_name: String, amount: int) -> void:
	if not _resources.has(resource_name):
		_resources[resource_name] = 0
	_resources[resource_name] += amount
	resource_changed.emit(resource_name, _resources[resource_name])

func spend(resource_name: String, amount: int) -> bool:
	if get_amount(resource_name) >= amount:
		_resources[resource_name] -= amount
		resource_changed.emit(resource_name, _resources[resource_name])
		return true
	return false

func can_afford(costs: Dictionary) -> bool:
	for resource_name in costs:
		if get_amount(resource_name) < costs[resource_name]:
			return false
	return true

func spend_multiple(costs: Dictionary) -> bool:
	if not can_afford(costs):
		return false
	for resource_name in costs:
		_resources[resource_name] -= costs[resource_name]
		resource_changed.emit(resource_name, _resources[resource_name])
	return true
