extends Area2D
class_name Enemy

@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var speed := 0


func _ready():
	speed = -1 if global_position.x > 320 else 1
	sprite.flip_h = true if global_position.x < 320 else false

func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self,"global_position",global_position+ Vector2(speed*24,0),.3)
	sprite.play("move")
	await  tween.finished
	sprite.play("default")

func timer_start(timer_wait: float):
	timer.wait_time = timer_wait
	timer.start()
