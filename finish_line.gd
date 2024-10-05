extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.name.to_lower() == "player":
		SignalBus.playerWon.emit()
	else:
		SignalBus.playerLost.emit()
