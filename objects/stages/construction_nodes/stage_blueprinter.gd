extends TileMapLayer
class_name StageBlueprinter

@export_category("Visual Flair")
@export var build_delay: float = 0.01

@export_category("Main Path")
@export var critical_path_length: int = 5
@export var min_exit_dist: int = 2
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

func initialize_new_stage() -> void:
	erase_path()
	
	if entry_point == null:
		entry_point = Vector2.ZERO
	
	# Establish list of points to path through en route to exit point
	initialize_waypoints()

	# Build the critical path
	initialize_critical_path()

func initialize_waypoints() -> void:
	for i in waypoint_count:
		var new_waypoint: Vector2i = Vector2i(randi_range(1, critical_path_length - 1), randi_range(0, vertical_limit))
			
		if waypoints.has(new_waypoint):
			pass
		else:
			waypoints.append(new_waypoint)
	
	waypoints.sort()

	randomize_entry_point()
	randomize_exit_point()
	
	waypoints.push_front(entry_point)
	waypoints.append(exit_point)

func initialize_critical_path() -> void:
	for i in waypoints:
		var index: int = waypoints.find(i)
		var target_cell: Vector2i
		
		if index == waypoints.size() - 1:
			randomize_exit_point()
			target_cell = exit_point
			await build_path(i, target_cell)
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

func get_exits(_cell: Vector2i) -> Array[Vector2i]:
	var _exits: Array[Vector2i]
	
	for cell in get_surrounding_cells(_cell):
		if get_cell_atlas_coords(cell) == Vector2i(-1, -1):
			# Discard the coordinates if there is no cell at those neighboring coordinates
			pass
		else:
			_exits.append(cell)
	
	return _exits

func get_chunk_map() -> Blueprint:
	var _chunk_map: Blueprint = Blueprint.new()
	var _cells: Array[Vector2i]
	var _data: Dictionary[Vector2i, int]
	
	
	
	for cell in get_used_cells():
		var _exit_bitmap: int = 0
		
		for exit in get_exits(cell):
			match exit - cell:
				Vector2i(0, 0):
					pass
				Vector2i(0, -1):
					_exit_bitmap += 1
				Vector2i(0, 1):
					_exit_bitmap += 2
				Vector2i(-1, 0):
					_exit_bitmap += 8
				Vector2i(1, 0):
					_exit_bitmap += 4
		
		if cell == entry_point:
			_exit_bitmap += 16
		elif cell == exit_point:
			_exit_bitmap += 32
		
		_data[cell] = _exit_bitmap

	_chunk_map.set_blueprint_data(_data)
	
	return _chunk_map

func erase_path() -> void:
	chunk_coords.clear()
	waypoints.clear()
	
	clear()

func randomize_entry_point() -> void:
	entry_point = Vector2(0, waypoints[0].y)

func randomize_exit_point() -> void:
	exit_point.x = waypoints.back().x + 1
	exit_point.y = waypoints.back().y
