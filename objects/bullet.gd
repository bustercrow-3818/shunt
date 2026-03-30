extends AnimatedSprite2D
class_name Projectile

@export var speed: float = 10
@export var damage: int = 4
@export var hitbox: Area2D
@export var screen_check: VisibleOnScreenEnabler2D
var direction: Vector2 = Vector2(1, 0)

func initialize() -> void:
	connect_signals()
	
func connect_signals() -> void:
	hitbox.body_entered.connect(deal_damage)
	screen_check.screen_exited.connect(screen_exit_delay)

func _physics_process(_delta: float) -> void:
	position += speed * direction * _delta
	
func deal_damage(target: Node2D) -> void:
	if target.has_method("take_damage"):
		target.take_damage(damage)
		queue_free()

func screen_exit_delay() -> void:
	await get_tree().create_timer(GlobalValues.bullet_offscreen_life).timeout
	queue_free()
