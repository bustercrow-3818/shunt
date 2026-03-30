extends Resource
class_name WeaponData

@export_category("Projectile Data")
@export var projectile: PackedScene
@export var number_of_projectiles: int = 1
@export var projectile_spacing: float = 4

@export_category("Misc. Weapon Data")
@export var recoil_force: float = 0.0
@export var cooldown_time: float = 0.1
var is_cooling_down: bool = false

@export_category("Attack Directions")
@export var attack_up: bool = false
@export var attack_down: bool = false
@export var attack_left: bool = true
@export var attack_right: bool = true

func initialize() -> void:
	connect_signals()
	
func connect_signals() -> void:
	pass

func get_first_projectile_position() -> Vector2:
	@warning_ignore("integer_division")
	var new_position_y = -(number_of_projectiles / 2) * projectile_spacing
	return Vector2(0, new_position_y)

func get_projectile_positions() -> Array[Vector2]:
	var projectile_positions: Array[Vector2]
	var next_position: Vector2 = get_first_projectile_position()
	
	for i in number_of_projectiles:
		projectile_positions.append(next_position)
		next_position.y += projectile_spacing
		
	return projectile_positions

func get_attack_directions() -> Array[StringName]:
	var dirs: Array[StringName]
	
	if attack_up == true:
		dirs.append("shoot_up")
	
	if attack_down == true:
		dirs.append("shoot_down")
		
	if attack_left == true:
		dirs.append("shoot_left")
		
	if attack_right == true:
		dirs.append("shoot_right")
		
	if dirs.is_empty():
		return ["shoot_left", "shoot_right"]
	else:
		return dirs
	
func get_recoil_vector(attack_direction: Vector2 = Vector2.RIGHT) -> Vector2:
	var force: float = float(number_of_projectiles) * recoil_force
	var recoil: Vector2
	
	recoil = -attack_direction * force
	
	return recoil
