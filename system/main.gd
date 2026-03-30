extends Node2D

func _ready() -> void:
	initialize()

func initialize() -> void:
	propagate_call("initialize_entity")
	propagate_call("initialize_object")
	connect_signals()
	
func connect_signals() -> void:
	
	pass
