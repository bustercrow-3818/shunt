extends TileMapLayer
class_name Chunk

func initialize_chunk() -> void:
	
	pass

func get_exits() -> Array[Vector2]:
	var exits: Array[Vector2]
	
	for i in get_children():
		if i is Marker2D:
			exits.append(i.global_position)
			
	return exits

func get_chunk_offsets() -> Dictionary[String, Vector2]:
	var chunk_offsets: Dictionary[String, Vector2]
	
	for i in get_exits():
		
		pass
	
	return chunk_offsets
