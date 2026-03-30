extends State

func enter_state(_previous_state: String) -> void:
	sprite.play("dead")
	await sprite.animation_finished
	entity.die()
	#entity.direction = Vector2.ZERO
	#entity.is_dead = true
	#entity.set_collision_layer_value(3, false)
	#entity.set_collision_mask_value(3, false)
	#await get_tree().create_timer(GlobalValues.death_fade_time).timeout
	#
	#entity.queue_free()
