extends Control


signal changed_location(location)

onready var awareness_panel = $VBoxContainer/LocalAwarenessPanel

func set_map(map_scene : PackedScene):
	awareness_panel.current_map = map_scene

func set_location(location : LocationData):
	awareness_panel.current_location = location

func _on_LocalAwarenessPanel_changed_location(location):
	interactables_panel.current_location = location
	emit_signal("changed_location", location)
