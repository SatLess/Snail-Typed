extends Node2D

var level: int = 0
var cur_level: Node


func _ready() -> void:
	cur_level = get_child(0)

func _change_level():
	level+=1
	var inst 
