@abstract
extends Resource
class_name Module

signal passive_instructions(data: Dictionary)

@export var MU_cost: int = 3

@abstract func activate() -> void

@abstract func deactivate() -> void

func passive_effect(data: Dictionary = {}) -> void:
	passive_instructions.emit(data)
