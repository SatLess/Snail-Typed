extends Control

@onready var container = $HBoxContainer
@export var max_keys: int = 5
var key_list: Array[Key] 

func _ready():
	
	SignalBus.RightLetter.connect(func(): 
		key_list.pop_front()
		if key_list.is_empty(): 
			print("won")
			return
		key_list[0].enabled = true
		)
	SignalBus.WrongLetter.connect(func(): pass)
	for i in max_keys:
		var inst = Key.new()
		key_list.append(inst)
		container.add_child(inst)
	
	key_list[0].enabled = true
