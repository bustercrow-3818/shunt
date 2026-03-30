extends CharacterBody2D
class_name Entity

@export var health: HealthComponent
@export var movement: MovementComponent
@export var sprite: AnimationPlayer
@export var flipper: Node2D
@export var state: StateMachine
@export var weapon: Weapon
@export var collider: CollisionShape2D

var is_dead: bool = false
var direction: Vector2 = Vector2(0, 0)

func initialize_entity() -> void:
	propagate_call("initialize", [], true)
	health.initialize()
	movement.initialize()
	connect_signals()
	
func connect_signals() -> void:
	
	pass
	
func take_damage(damage: int) -> void:
	if is_dead == false:
		health.take_damange(damage)
		state.change_state("hit")

func _physics_process(_delta: float) -> void:
	fall()
	if not is_dead:
		move_and_slide()

func recoil(_amount: float = 0, _dir: Vector2 = Vector2.ZERO) -> void:
	
	pass

func horizontal_motion(_dir: float) -> void:
	if direction.x != 0:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, direction.x * movement.move_speed, movement.ground_accel)
		else:
			velocity.x = move_toward(velocity.x, direction.x * movement.move_speed, movement.air_accel)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, movement.ground_decel)
		else:
			velocity.x = move_toward(velocity.x, 0, movement.air_decel)
		
	sprite_flip(direction.x)

func jump() -> void:
	velocity.y -= movement.jump_speed

func sprite_flip(_dir: float) -> void:
	if _dir < 0:
		flipper.scale.x = -1
	elif _dir > 0:
		flipper.scale.x = 1

func fall() -> void:
	if velocity.y <= GlobalValues.terminal_velocity:
		velocity.y += GlobalValues.gravity

func die() -> void:
	direction = Vector2.ZERO
	is_dead = true
	self.process_mode = Node.PROCESS_MODE_DISABLED
	
	await get_tree().create_timer(GlobalValues.death_fade_time).timeout
	queue_free()
