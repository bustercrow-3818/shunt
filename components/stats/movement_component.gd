extends Component
class_name MovementComponent

@export_category("Horizontal Movement")
@export var move_speed: float = 125
@export var acceleration: float = 1
@export var deceleration: float = 50
@export var attack_slowdown_modifier: float = 0.65

@export_category("Vertical Movement")
@export var jump_speed: float = 30
@export var max_jump_height: float = 150
@export var maximum_jumps: int = 1
var remaining_jumps: int = 1

func initialize() -> void:
	reset_jump_counter()

func reset_jump_counter() -> void:
	remaining_jumps = maximum_jumps
