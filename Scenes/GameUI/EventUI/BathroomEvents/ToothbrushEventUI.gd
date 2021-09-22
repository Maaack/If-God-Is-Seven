extends InteractableEventUI

func _on_BrushTeethButton_pressed():
	log_event_text("You brushed your teeth with your toothbrush.")
	emit_signal("attempted_waiting", 2)
	end_event()
