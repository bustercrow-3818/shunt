extends Node2D
class_name ChunkPopulator

@export var chunk_pool: ChunkPool
@export var chunk_size: int = 8
@export var test_blueprint: Blueprint

func _ready() -> void:
	%Button.pressed.connect(build_blueprint.bind(test_blueprint))

func build_blueprint(_bp: Blueprint) -> void:
	print("building %s tiles" % str(_bp._chunk_map.size()))
	for chunk in _bp._chunk_map:
		print("processing chunk %s" % str(_bp._chunk_map[chunk]))
		var _valid_options: Array[ChunkData]
		var new_chunk_data: ChunkData
		var new_chunk: TileMapLayer
		
		for i in chunk_pool.chunks:
			if i.exit_bitmask == _bp._chunk_map[chunk]:
				_valid_options.append(i)
			else:
				pass
		new_chunk_data = _valid_options.pick_random()
		new_chunk = new_chunk_data.chunk.instantiate()
		place_chunk(new_chunk, chunk * new_chunk_data.get_coord_offset())
		

func place_chunk(_chunk: TileMapLayer, _coords: Vector2i) -> void:
	print("placing chunk %s" % str(_chunk))
	add_child(_chunk)
	_chunk.global_position = _coords
