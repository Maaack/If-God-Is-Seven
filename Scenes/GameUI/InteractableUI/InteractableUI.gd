extends Control


signal changed_location(location)


func _on_InteractablesPanel_changed_location(location):
	emit_signal("changed_location", location)
