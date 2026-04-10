extends Resource
class_name Blueprint

@warning_ignore("unused_private_class_variable")
@export var _chunk_map: Dictionary[Vector2i, int]

func set_blueprint_data(_data: Dictionary[Vector2i, int]) -> void:
	_chunk_map = _data
	print(str(_data))
