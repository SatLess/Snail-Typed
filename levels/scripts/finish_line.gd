extends Area2D
class_name  FinishLine

func _on_area_entered(area: Area2D) -> void:
	if area.name.to_lower() == "player":
		SignalBus.playerWon.emit()
	else:
		SignalBus.playerLost.emit()
	SignalBus.winner_position.emit(area.global_position)
	queue_free()

func change_col_pos(pos: float):
	$CollisionShape2D.global_position.x = pos
