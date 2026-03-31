extends TileMapLayer
class_name StageBlueprinter

@export_category("Main Path")
@export var critical_path_length: int = 5
@export var vertical_limit: int = 3

@export_category("Branch Paths")
@export var branch_path_qty: int = 0
@export var branch_path_max_length: int = 0

@export_category("Waypoints")
@export var waypoint_count: int = 1
@export var waypoint_path_length: int = 3

@export_category("Alternate Configuration")
@export var stage_width: int = 8
@export var stage_height: int = 4
@export var grid_waypoints: int = 3
@export var grid_waypoint_length: int = 3
var base_grid: Rect2i

var entry_point: Vector2i = Vector2i.ZERO
var waypoints: Array[Vector2i]
var exit_point: Vector2i

func _ready() -> void:
	initialize_new_stage()

func initialize_new_stage() -> void:
	
	# Establish list of points to path through en route to exit point
	for i in waypoint_count:
		var y_distance: int = randi_range(0, min(waypoint_path_length, vertical_limit))
		var x_distance: int = waypoint_path_length - y_distance
		var new_waypoint: Vector2i
		
		if waypoints.is_empty():
			waypoints.append(entry_point)
		else:
			new_waypoint = waypoints.back() + Vector2i(x_distance * [-1, 1].pick_random(), y_distance * [-1, 1].pick_random())
			waypoints.append(new_waypoint)
		
		print("finished compiling list of waypoints: %s" % waypoints)
	
	exit_point = waypoints.back()

	# Build the critical path
	print("building with %s waypoints" % waypoints.size())
	for i in waypoints:
		var target_cell: Vector2i = waypoints[1]
		if waypoints.size() > 1:
			print("building path to %s" % i)
			build_path(i, target_cell, waypoint_path_length)
			waypoints.erase(i)
		else:
			pass

func build_path(starting_point_coords: Vector2i, end_coords: Vector2i, path_length: int = 0) -> void:
	var remaining_path: int = path_length
	var current_cell: Vector2i = starting_point_coords
	
	if randi_range(0, 1) == 1 and current_cell.x != end_coords.x:
		current_cell.x = int(move_toward(current_cell.x, end_coords.x, 1))
		remaining_path -= 1
	elif current_cell.y != end_coords.y:
		current_cell.y = int(move_toward(current_cell.y, end_coords.y, 1))
		remaining_path -= 1
	else:
		pass
	
	print("placing tile at %s" % current_cell)
	set_cells_terrain_connect([current_cell], 0, 0)
	
	if remaining_path > 0 and end_coords != current_cell:
		build_path(current_cell, end_coords, remaining_path)

func build_grid() -> void:
	base_grid.position = Vector2i.ZERO
	base_grid.size = Vector2i(stage_width, stage_height)
	
	var grid_entry_position: Vector2i = Vector2i(0, randi_range(0, stage_height))
	var grid_exit_position: Vector2i = Vector2i(stage_width, randi_range(0, stage_height))
	
	
