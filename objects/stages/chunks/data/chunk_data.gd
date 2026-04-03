extends Resource
class_name ChunkData

@export var chunk: PackedScene
@export_flags("North", "South", "East", "West") var exit_bitmask
@export var weight: float = 1.0
