extends BedEventUI


func _ready():
	body_label.text = get_body_text() % [get_made_state_text()]

func _on_MakeButton_pressed():
	if source_interactable.made_state < source_interactable.made_states.GOOD:
		source_interactable.make_bed()
		emit_signal("added_historical_note", "You made the BED for a bit.")
	else:
		emit_signal("added_historical_note", "You failed to make the BED look better.")
	emit_signal("attempted_waiting", 1)
	queue_free()

func _on_SleepButton_pressed():
	emit_signal("added_historical_note", "You slept in the BED for a full 24 hours!")
	emit_signal("attempted_waiting", 1440)
	queue_free()
