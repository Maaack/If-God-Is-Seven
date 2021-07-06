extends Control


func _on_InteractableUI_changed_location(location):
	$Background.texture = location.background
	$HeaderUI/VBoxContainer/HBoxContainer/TemporalAwarenessPanel.add_event("You enter %s" % location.title.to_upper())
	$HeaderUI/VBoxContainer/HBoxContainer/TemporalAwarenessPanel.add_time(0, 1)
