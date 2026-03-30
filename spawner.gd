extends Node2D
class_name Spawner

@export var spawn_timer: Timer
@export var spawned_entity: PackedScene
@export var max_population: int = 1
@export var spawn_interval: float = 2.0
var current_population: int = 0

func _ready() -> void:
	initialize()

func initialize() -> void:
	spawn_timer.wait_time = spawn_interval
	connect_signals()
	spawn_timer.start()
	
func connect_signals() -> void:
	spawn_timer.timeout.connect(check_population)

func spawn_entity() -> void:
	var new_entity: Entity = spawned_entity.instantiate()
	
	
	new_entity.global_position = global_position
	new_entity.initialize_entity()
	if new_entity.health.dead.is_connected(population_killed):
		pass
	else:
		new_entity.health.dead.connect(population_killed)
	
	get_tree().current_scene.add_child(new_entity)
	
	current_population += 1

func population_killed() -> void:
	print("changing pop count from %s to %s" % [current_population, current_population - 1])
	current_population -= 1
	
	if current_population < 0:
		current_population = 0

func check_population() -> void:
	if current_population < max_population:
		spawn_entity()
	else:
		return
