extends TileMapLayer
class_name StageBlueprinter

@export_category("Visual Flair")
@export var build_delay: float = 0.01

@export_category("Main Path")
@export var critical_path_length: int = 5
@export var vertical_limit: int = 3
@export var waypoint_count: int = 1

@export_category("Chunk Settings")
@export var chunk_size: int = 8 ## Size of sides for each square chunk


var entry_point: Vector2i = Vector2i.ZERO
var waypoints: Array[Vector2i]
var exit_point: Vector2i

func _ready() -> void:
	initialize_new_stage()

func initialize_new_stage() -> void:
	exit_point = entry_point + Vector2i(randi_range(1, critical_path_length), randi_range(1, min(critical_path_length, vertical_limit)))
	
	# Establish list of points to path through en route to exit point
	initialize_waypoints()

	# Build the critical path
	initialize_critical_path()

func initialize_waypoints() -> void:
	waypoints.append(entry_point)
	
	for i in waypoint_count:
		var new_waypoint: Vector2i = Vector2i(randi_range(min(entry_point.x, exit_point.x), max(entry_point.x, exit_point.x)),randi_range(min(entry_point.y, exit_point.y), max(entry_point.y, exit_point.y)) )
			
		if waypoints.has(new_waypoint):
			waypoint_count += 1
		else:
			waypoints.append(new_waypoint)
			
	waypoints.sort()

func initialize_critical_path() -> void:
	for i in waypoints:
		var index: int = waypoints.find(i)
		var target_cell: Vector2i
		
		if index == waypoints.size() - 1:
			pass
		else:
			target_cell = waypoints[index + 1]
			await build_path(i, target_cell)

func build_path(starting_point_coords: Vector2i, end_coords: Vector2i) -> void:
	var current_cell: Vector2i = starting_point_coords
	
	set_cells_terrain_connect([current_cell], 0, 0)
	
	while current_cell != end_coords:
		if randi_range(0, 1) == 1 and current_cell.x != end_coords.x:
			current_cell.x = int(move_toward(current_cell.x, end_coords.x, 1))
		elif current_cell.y != end_coords.y:
			current_cell.y = int(move_toward(current_cell.y, end_coords.y, 1))
		else:
			pass
		
		set_cells_terrain_connect([current_cell], 0, 0)
		await get_tree().create_timer(build_delay).timeout

func populate_chunks() -> void:
	var blueprint: Array[Vector2i] = get_used_cells()
	
	for tile in blueprint:
		var neighbors: Array[Vector2i] = get_cell_neighbors(tile)
		pass
	pass

func get_cell_neighbors(cell_coordinates: Vector2i) -> Array[Vector2i]:
	var neighbors: Array[Vector2i]
	
	for i in get_surrounding_cells(cell_coordinates):
		if get_cell_tile_data(i) == null:
			pass
		else:
			neighbors.append(i)
	
	return neighbors
	
func populate_room(coords: Vector2i, exits: Array[Vector2i]) -> void:
	var corners: Array[Vector2i] = [coords + Vector2i(chunk_size, chunk_size), coords + Vector2i(-chunk_size, chunk_size), coords + Vector2i(-chunk_size, -chunk_size), coords + Vector2i(chunk_size, -chunk_size)]
	
	
	pass
