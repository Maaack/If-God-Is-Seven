extends Control


func _on_LocalAwarenessPanel_changed_location(location : LocationData):
	$Background.texture = location.background
	$HeaderUI/TemporalAwarenessPanel.add_event("You enter %s" % location.title.to_upper())
