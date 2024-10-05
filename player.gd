extends Area2D
class_name Player

@export var speed: float = 16
@onready var sprite: AnimatedSprite2D = $sprite
var is_tweening: bool = false
var move_num: int = 0
var offset

func _ready():
	if global_position.x > 320:
		offset = 640 - global_position.x
	else: offset = global_position.x
	speed = -1 if global_position.x > 320 else 1
	sprite.flip_h = true if global_position.x < 320 else false
	SignalBus.RightLetter.connect(func(): move_num += 1)

func _physics_process(delta):
	if move_num and is_tweening == false:
		for i in move_num:
			var tween = create_tween()
			tween.tween_property(self,"global_position",global_position+ Vector2(speed,0),.3)
			sprite.play("schmoving")
			is_tweening = true
			await tween.finished
			move_num -= 1
		is_tweening = false
	if move_num == 0:
		sprite.play("idle")

#func _input(event):
	#if Input.is_action_just_pressed("ui_accept"):
		#move_num += 1
