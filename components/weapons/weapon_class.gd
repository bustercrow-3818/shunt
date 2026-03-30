extends Node2D
class_name Weapon


@export var weapon_data: WeaponData
@export var sprite: AnimationPlayer
var entity: Entity

var attack_directions: Array[StringName]
var is_cooling_down: bool = false

func initialize() -> void:
	entity = get_parent()
	weapon_data.initialize()
	attack_directions = weapon_data.get_attack_directions()
	connect_signals()
	
func connect_signals() -> void:
	
	pass

func _unhandled_input(event: InputEvent) -> void:
	if entity is not Player:
		pass
	else:
		if event.is_action_pressed("shoot_up") and attack_directions.has("shoot_up"):
			fire(Vector2(0, -1))
		elif event.is_action_pressed("shoot_down") and attack_directions.has("shoot_down"):
			fire(Vector2(0, 1))
		elif event.is_action_pressed("shoot_left") and attack_directions.has("shoot_left"):
			fire(Vector2(-1, 0))
		elif event.is_action_pressed("shoot_right") and attack_directions.has("shoot_right"):
			fire(Vector2(1, 0))

func _physics_process(_delta: float) -> void:
	pass

func fire(_dir: Vector2 = Vector2.ZERO) -> void:
	var projectile_positions: Array[Vector2] = weapon_data.get_projectile_positions()
	
	if not is_cooling_down:
		is_cooling_down = true
		
		play_attack_animation()
		
		for i in weapon_data.number_of_projectiles:
			spawn_bullet(_dir, projectile_positions[i])
		
		recoil(weapon_data.get_recoil_vector(_dir))
		
		cooldown()

func cooldown() -> void:
	await get_tree().create_timer(weapon_data.cooldown_time).timeout
	is_cooling_down = false

func spawn_bullet(direction: Vector2, spawn_position: Vector2) -> void:
	var new_bullet: Projectile = weapon_data.projectile.instantiate()
	
	new_bullet.initialize()
	new_bullet.direction = direction
	new_bullet.rotation = direction.angle()
	new_bullet.global_position = self.global_position + spawn_position
	get_tree().current_scene.add_child(new_bullet)

func play_attack_animation() -> void:
	var old_animation: String
		
	if sprite.current_animation == "attack":
		sprite.stop()
	else:
		old_animation = sprite.current_animation
		
	sprite.play("attack")
	await sprite.animation_finished
	sprite.play(old_animation)

func recoil(_dir: Vector2 = Vector2.ZERO) -> void:
	entity.velocity += _dir
