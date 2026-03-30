@abstract
extends Resource
class_name Shunt

@export var mu_bonus: int = 5

@abstract func activate(entity: Entity) -> void

@abstract func deactivate(entity: Entity) -> void
