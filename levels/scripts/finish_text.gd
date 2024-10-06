extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var color_rect_2: ColorRect = $ColorRect2
@onready var the_winner_is: Label = $"The winner is"
@onready var proceed: Label = $Proceed
@onready var winner_name: Label = $winnerName
@onready var playerwon: Label = $playerwon

var has_won
var enable_input: bool = false

func _ready() -> void:
	hide()
	SignalBus.playerWon.connect(func():
		show()
		proceed.text = "Press R to go to next level!"
		has_won = true
		enable_input = true
		)
	
	SignalBus.playerLost.connect(func():
		show()
		playerwon.hide()
		proceed.text = "Press R to try again!"
		winner_name.text = "Snail...?"
		has_won = false
		enable_input = true
		)
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_R) and enable_input == true:
		if has_won: SignalBus.nextLevel.emit()
		elif has_won == false: SignalBus.reset_level.emit()
		
