extends Resource
class_name ChunkData

@export var chunk: PackedScene
@export_flags("North:1", "South:2", "East:4", "West:8") var exit_bitmask
@export var weight: float = 1.0
