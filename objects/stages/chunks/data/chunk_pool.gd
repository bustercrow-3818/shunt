extends Resource
class_name ChunkPool

@export var chunks: Array[ChunkData]

func get_random_chunk(_exit_bitmask: int = 0) -> PackedScene:
	var _valid_options: Array[ChunkData]
	
	for chunk in chunks:
		if chunk.exit_bitmask == _exit_bitmask:
			_valid_options.append(chunk)
	
	if _valid_options.is_empty():
		return null
	else:
		return _valid_options.pick_random().chunk
