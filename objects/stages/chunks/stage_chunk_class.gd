extends TileMapLayer
class_name Chunk

@export var exit_positions: Dictionary[String, bool] = {"Top": false, "Bottom": false, "Left": false, "Right": false}

func initialize_chunk() -> void:
	
	pass

func get_exits() -> Array[String]:
	var exits: Array[String]
	
	for i in exit_positions:
		if exit_positions[i] == true:
			exits.append(exit_positions.find_key(i))
			
	return exits

func snap_to_neighbor_exit(neighbor_exit: String, neighbor: Chunk) -> void: ## Takes an input neighbor and the exit this tile is attempting to connect to and decides how to connect to it. This function should be called by a chunk manager to ensure proper coordination.
	var neighbor_position: Vector2 = neighbor.global_position
	var neighbor_size: Vector2 = neighbor.get_used_rect().size * neighbor.tile_set.tile_size.x
	
	match neighbor_exit:
		"Top":
			global_position = neighbor_position
			global_position.y -= neighbor_size.y
		"Bottom":
			global_position = neighbor_position
			global_position.y += neighbor_size.y
		"Left":
			global_position = neighbor_position
			global_position.x -= neighbor_size.x
		"Right":
			global_position = neighbor_position
			global_position.x += neighbor_size.x
