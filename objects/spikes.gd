extends StaticBody2D


@export var collision_damage: int = 10
@export var collision_hitbox: Area2D

func initialize_object() -> void:
	connect_signals()
	
func connect_signals() -> void:
	collision_hitbox.body_entered.connect(deal_collision_damge)
	
func deal_collision_damge(body: Node2D) -> void:
	print("trying to hurt %s" % body.name)
	
	if body is Player:
		body.take_damage(collision_damage)
