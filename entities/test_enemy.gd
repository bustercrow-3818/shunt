extends Entity
class_name NPC

@export_category("Stats")
@export var collision_damage: int = 4

@export_category("Misc Node References")
@export var collision_hitbox: Area2D

@export_category("Movement AI")
@export var patrol_timer: Timer
@export var wall_check: RayCast2D
@export var wall_check_range: float = 32
@export var ledge_check: Area2D
@export var ledge_check_distance_h: float = 32
@export var ledge_check_distance_v: float = -48

#func _ready() -> void:
	#initialize_entity()

func connect_signals() -> void:
	patrol_timer.timeout.connect(toggle_patrol)
	collision_hitbox.body_entered.connect(deal_collision_damage)
	

#func _process(_delta: float) -> void:
	#
	#if is_node_ready():
		#%debug.text = str(state.current_state.name)

func _physics_process(_delta: float) -> void:
	super(_delta)
	avoid_wall_collision()


func toggle_patrol() -> void:
	if direction != Vector2.ZERO:
		direction = Vector2.ZERO
		wall_check.target_position = Vector2.ZERO
		ledge_check.position = Vector2.ZERO
	else:
		direction.x += randi_range(-1, 1)
		wall_check.target_position = Vector2(wall_check_range * direction.x, 0)
		ledge_check.position = Vector2(ledge_check_distance_h * direction.x, ledge_check_distance_v)

func reverse_direction() -> void:
	direction.x *= -1
	wall_check.target_position *= -1

func avoid_wall_collision() -> void:
	if wall_check.is_colliding():
		if is_wall_too_high():
			print("wall is too high, turning around")
			reverse_direction()
		elif is_on_floor():
			state.change_state("jump")
	#else:
		#direction.y -= 1

func is_wall_too_high() -> bool:
	if ledge_check.has_overlapping_bodies():
		return true

	return false

func deal_collision_damage(body: Node2D) -> void:
	if body is Player:
		body.take_damage(collision_damage)
		
	reverse_direction()
