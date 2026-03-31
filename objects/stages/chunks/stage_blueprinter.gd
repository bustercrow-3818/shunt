extends TileMapLayer
class_name StageBlueprinter

@export var critical_path_length: int = 5

var entry_point: Vector2i = Vector2i.ZERO
var exit_point: Vector2i

func _ready() -> void:
	initialize_new_stage()

func initialize_new_stage() -> void:
	var x_distance: int = randi_range(0, critical_path_length)
	var y_distance: int = critical_path_length - x_distance
	
	exit_point = entry_point + Vector2i(x_distance * [-1, 1].pick_random(), y_distance * [-1, 1].pick_random())
	
	set_cell(entry_point, 0)
	
	set_cells_terrain_connect([entry_point, exit_point], 0, 0)

func build_critical_path(starting_point_coords: Vector2i, x_length: int = 0, y_length: int = 0, ) -> void:
	var remaining_path: Vector2i = Vector2i(x_length, y_length)
	var current_cell: Vector2i = starting_point_coords
	
	for i in x_length + y_length:
		
		pass
	pass

func decide_next_cell(current_cell_coords: Vector2i, x_max: int, y_max: int) -> Vector2i:
	var next_cell: Vector2i
	
	next_cell.x = current_cell_coords.x + randi_range(0, x_max)
	next_cell.y = current_cell_coords.y + randi_range(0, y_max)
	
	return next_cell
