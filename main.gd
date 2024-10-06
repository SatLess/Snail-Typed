extends Node2D

var cur_level: Node
var inst
@export var levels: Array[PackedScene]

func _ready() -> void:
	SignalBus.nextLevel.connect(_change_level)
	SignalBus.reset_level.connect(_reset_level)
	cur_level = get_child(0)

func _change_level():
	if levels.is_empty(): return
	
	inst = levels.pop_front()
	var a = inst.instantiate()
	add_child(a)
	cur_level.queue_free()
	cur_level = a

func _reset_level():
	cur_level.queue_free()
	var a = inst.instantiate()
	add_child(a)
	cur_level = a
