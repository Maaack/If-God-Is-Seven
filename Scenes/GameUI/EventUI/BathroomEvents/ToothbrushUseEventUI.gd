extends EventUI


func _on_BrushTeethButton_pressed():
	emit_signal("added_historical_note", "You brushed your teeth with YOUR TOOTHBRUSH.")
	emit_signal("attempted_waiting", 2)
	end_event()
