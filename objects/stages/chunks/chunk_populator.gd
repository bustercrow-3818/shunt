extends Node2D
class_name ChunkPopulator

@export var chunk_pool: ChunkPool

func build_blueprint(_bp: Blueprint) -> void:
	for chunk in _bp._chunk_map:
		
		pass
	pass

func place_chunks(_coords: Array[Vector2i], _chunk_size: int) -> void:
	
	pass
