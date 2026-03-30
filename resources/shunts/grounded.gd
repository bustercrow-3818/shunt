extends Shunt
class_name GroundedShunt



var original_jump_speed: float

func activate(entity: Entity) -> void:
	original_jump_speed = entity.movement.jump_speed
	entity.movement.jump_speed *= 0.25
	
func deactivate(entity: Entity) -> void:
	entity.movement.jump_speed = original_jump_speed
