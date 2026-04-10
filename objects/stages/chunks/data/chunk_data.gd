extends Resource
class_name ChunkData

@export var chunk: PackedScene
@export_flags("North:1", "South:2", "East:4", "West:8") var exit_bitmask: int
@export var weight: float = 1.0
@export var tile_size: int = 32
@export var chunk_size: int = 16

func get_coord_offset() -> int:
	return tile_size * chunk_size
