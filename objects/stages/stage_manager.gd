extends Node2D
class_name StageManager

@export var builder: ChunkPopulator
@export var pathing: StageBlueprinter
@export var chunk_pools: Dictionary[StringName, ChunkPool]

var player_spawn_point: Vector2

func _ready() -> void:
	$debug_list/VBoxContainer/Button.pressed.connect(build_blueprinter_stage)

func build_blueprinter_stage() -> void:
	var next_stage: Blueprint = pathing.get_chunk_map()
	
	builder.build_blueprint(next_stage)
	
