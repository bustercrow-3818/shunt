extends TileMapLayer
class_name StageBlueprinter

@export_category("Visual Flair")
@export var build_delay: float = 0.01

@export_category("Main Path")
@export var critical_path_length: int = 5
@export var vertical_limit: int = 3
@export var waypoint_count: int = 1

@export_category("Chunk Settings")
@export var chunk_size: int = 4 ## Half the intended size of sides for each square chunk


var entry_point: Vector2i = Vector2i.ZERO
var waypoints: Array[Vector2i]
var exit_point: Vector2i

var chunk_coords: Array[Vector2i]

func _ready() -> void:
	initialize_new_stage()
	%button.pressed.connect()

func initialize_new_stage() -> void:
	chunk_coords.clear()
	waypoints.clear()
	
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
		chunk_coords.append(current_cell)
		await get_tree().create_timer(build_delay).timeout

func populate_chunks() -> void:
	var blueprint: Array[Vector2i] = get_used_cells()
	
	for tile in blueprint:
		var _neighbors: Array[Vector2i] = get_cell_neighbors(tile)
		build_chunk(tile, _neighbors)
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
	
func get_door_coords(_origin_cell: Vector2i, _neighbor_cell: Vector2i) -> Array[Vector2i]:
	var _coords: Array[Vector2i]
	var _diff: Vector2i = _neighbor_cell - _origin_cell
	var _direction: Vector2i = Vector2i(sign(_diff.x), sign(_diff.y))
	
	match _direction:
		Vector2i.UP:
			pass
			
		Vector2i.RIGHT:
			pass
		
		Vector2i.DOWN:
			pass
		
		Vector2i.LEFT:
			pass
	
	
	return _coords
	
func build_chunk(_coords: Vector2i, _exits: Array[Vector2i]) -> void:
	var _chunk_corners: Rect2i = Rect2i(_coords - Vector2i(chunk_size, chunk_size), Vector2i(chunk_size, chunk_size))
	var _wall_cells: Array[Vector2i]
	var _door_coords: Array[Vector2i]
	
	# Top and Bottom sides
	for x in range(_chunk_corners.position.x, _chunk_corners.end.x):
		_wall_cells.append(Vector2i(x, _chunk_corners.position.y)) # Top
		_wall_cells.append(Vector2i(x, _chunk_corners.end.y - 1))  # Bottom
		
	# Left and Right sides (excluding corners already added)
	for y in range(_chunk_corners.position.y + 1, _chunk_corners.end.y - 1):
		_wall_cells.append(Vector2i(_chunk_corners.position.x, y)) # Left
		_wall_cells.append(Vector2i(_chunk_corners.end.x - 1, y))  # Right
	
	set_cells_terrain_connect(_wall_cells,0, 0)
