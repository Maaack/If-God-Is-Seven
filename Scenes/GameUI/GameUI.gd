extends Control


func _on_LocalAwarenessPanel_changed_location(location : LocationData):
	$Background.texture = location.background
