extends Entity
class_name Player

@export var test_shunt: Shunt

var current_mu: int = 0
var shunts: Array[Shunt]

func initialize_entity() -> void:
	super()
	%hp_display.text = "HP: " + str(health.current_hp)

#func _process(_delta: float) -> void:
	#%debug.text = str(state.current_state.name)

func _physics_process(_delta: float) -> void:
	direction.x = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("up"):
		direction.y = -1

	super(_delta)

func connect_signals() -> void:
	%test_button.pressed.connect(toggle_test_shunt)
	pass

func gain_shunt(new_shunt: Shunt) -> void:
	new_shunt.activate(self)
	shunts.append(new_shunt)

func remove_shunt(old_shunt: Shunt) -> void:
	shunts[shunts.find(old_shunt)].deactivate(self)
	shunts.erase(old_shunt)

func toggle_test_shunt() -> void:
	if shunts.has(test_shunt):
		remove_shunt(test_shunt)
	else:
		gain_shunt(test_shunt)

func take_damage(damage: int) -> void:
	super(damage)
	%hp_display.text = "HP: " + str(health.current_hp)
