extends Node2D
class_name Level

@onready var player: Area2D = $player
@onready var type_manager: Control = $CanvasLayer/TypeManager
@export var finish_line: float = 592
@export var enemy_timer: float = .5
@export var range_enemy = .15
@onready var countdown: Label = $CanvasLayer/Countdown
@onready var countdown_timer: Timer = $CanvasLayer/countdownTimer
var timer = 3

func _ready() -> void:
	randomize()
	get_tree().paused = true
	SignalBus.playerWon.connect(func(): 
		print("ele e bao dms")
		player.process_mode = Node.PROCESS_MODE_INHERIT
		get_tree().paused = true)
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
	countdown.text = str(timer)
