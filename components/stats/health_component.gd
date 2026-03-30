extends Component
class_name HealthComponent

signal dead

@export var max_hp: int = 10
var current_hp: int

func initialize() -> void:
	super()
	initialize_health()

func take_damange(amount: int = 0) -> void:
	current_hp -= amount
	if current_hp <= 0:
		dead.emit()

func heal(amount: int = 0) -> void:
	current_hp += amount

func initialize_health() -> void:
	current_hp = max_hp
