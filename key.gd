extends Label
class_name Key

@export var letter: int
var enabled: bool = false

func _ready():
	add_theme_font_size_override("font_size",32)
	text = String.chr(letter)

func _init():
	randomize()
	if letter: return
	else: letter = (randi_range(65,65+24))
	#set_process_shortcut_input(false)

func _unhandled_input(event):
	var just_pressed = event.is_pressed() and not event.is_echo() and enabled
	if Input.is_key_pressed(letter) and just_pressed: 
		SignalBus.RightLetter.emit()
		queue_free()
	elif not Input.is_key_pressed(letter) and just_pressed: print("duck/snail killer") 
