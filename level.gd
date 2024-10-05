extends Node2D
class_name Level

@onready var player: Area2D = $player
@onready var type_manager: Control = $CanvasLayer/TypeManager
@export var finish_line: float = 592

func _ready() -> void:
	SignalBus.playerWon.connect(func(): print("ele e bao dms"))
	player.speed *= (finish_line-player.offset)/type_manager.max_keys
	
