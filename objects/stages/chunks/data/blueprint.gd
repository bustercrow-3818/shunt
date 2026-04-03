extends Resource
class_name Blueprint

@warning_ignore("unused_private_class_variable")
@export var _chunk_map: Dictionary[Vector2, int]

func set_blueprint_data(_data: Dictionary[Vector2, int]) -> void:
	_chunk_map = _data
