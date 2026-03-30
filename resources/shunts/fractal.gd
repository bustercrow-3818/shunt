extends Shunt
class_name FractalShunt

var original_health: int

func activate(_entity: Entity) -> void:
	original_health = _entity.health.max_hp
	_entity.health.max_hp = 1
	if _entity.health.current_hp > 1:
		_entity.health.initialize_health()

	
func deactivate(_entity: Entity) -> void:
	_entity.health.max_hp = original_health
