extends Resource
class_name Blueprint

@warning_ignore("unused_private_class_variable")
@export var _chunk_map: Dictionary[Vector2i, int]
@export var player_spawn_coords: Vector2i

func set_blueprint_data(_data: Dictionary[Vector2i, int]) -> void:
	_chunk_map = _data
	player_spawn_coords = _data.keys()[0]
	print(str(_data))
	
