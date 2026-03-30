extends Shunt
class_name UnstableShunt ## Drastically reduces friction applied to slowing the player down both on the ground and in the air.

@export var new_decel: float = 1

var old_ground_decel: float
var old_air_decel: float

func activate(entity: Entity) -> void:
	old_air_decel = entity.movement.air_decel
	old_ground_decel = entity.movement.ground_decel
	
	entity.movement.air_decel = new_decel
	entity.movement.ground_decel = new_decel
	
func deactivate(entity: Entity) -> void:
	entity.movement.air_decel = old_air_decel
	entity.movement.ground_decel = old_ground_decel
