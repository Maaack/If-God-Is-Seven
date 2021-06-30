extends Control


func _on_LocalAwarenessUI_changed_location(location):
	$Background.texture = location.background
	$HeaderUI/TemporalAwarenessPanel.add_event("You enter %s" % location.title.to_upper())
	$HeaderUI/TemporalAwarenessPanel.add_time(0, 1)
