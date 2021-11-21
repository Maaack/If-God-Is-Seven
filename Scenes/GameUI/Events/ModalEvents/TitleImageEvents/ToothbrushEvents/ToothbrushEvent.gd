extends ModalEvent


func _on_BrushTeethButton_pressed():
	add_note("You brushed your teeth with your toothbrush.")
	add_time(2)
	end_event()
