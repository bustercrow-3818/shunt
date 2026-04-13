extends TileMapLayer
class_name Entry

signal broadcast_spawn(pos: Vector2)

@export var spawn_point: Marker2D

func _ready() -> void:
	broadcast_spawn.emit(spawn_point.global_position)
