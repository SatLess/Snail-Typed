extends Node2D
class_name Level

@onready var player: Area2D = $player
@onready var type_manager: Control = $CanvasLayer/TypeManager
@export var finish_line: float = 592
@export var enemy_timer: float = .5
@export var range_enemy = .15
@onready var countdown: Label = $CanvasLayer/Countdown
@onready var countdown_timer: Timer = $CanvasLayer/countdownTimer
@onready var audio: AudioStreamPlayer2D = $CanvasLayer/AudioStreamPlayer2D
@onready var camera: Camera2D = $Camera2D

var timer = 3

var winner: Node2D

func _ready() -> void:
	randomize()
	get_tree().paused = true
	
	SignalBus.winner_position.connect(func(pos: Vector2):
		
		camera.enabled = true
		var tween = create_tween().set_parallel(true)
		tween.tween_property(camera,"offset",pos,.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
		tween.tween_property(camera,"zoom",Vector2(2,2),1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
		
		)
	
	SignalBus.playerWon.connect(func(): 
		print("ele e bao dms")
		type_manager.hide()
		player.process_mode = Node.PROCESS_MODE_INHERIT
		get_tree().paused = true)
	
	SignalBus.playerLost.connect(func():
		type_manager.hide()
		type_manager.process_mode = Node.PROCESS_MODE_DISABLED)
	
	countdown_timer.start()
	player.speed *= (finish_line-player.offset)/type_manager.max_keys
	for i in get_children():
		if i is Enemy: 
			i.timer_start(randf_range(enemy_timer - range_enemy,enemy_timer+range_enemy))


func _on_countdown_timer_timeout() -> void:
	timer-=1
	if timer == 0:
		get_tree().paused = false
		countdown.hide()
		countdown_timer.stop()
		var k :AudioStreamWAV = load("res://start.wav")
		audio.stream = k
	countdown.text = str(timer)
	audio.play()
