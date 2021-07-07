extends Control


class_name InteractableMap

signal mouse_entered_location(location)
signal mouse_exited_location(location)
signal pressed_location(location)

export(String) var title : String

var current_location setget set_current_location

func set_current_location(value : LocationData):
	if value == current_location:
		return
	current_location = value
	for child in get_children():
		if child is LocationButton:
			child.pressed = (child.location == value)

func get_locations():
	var all_locations : Array = []
	for child in get_children():
		if child is LocationButton:
			all_locations.append(child.location)
	return all_locations

func setup_signals():
	for child in get_children():
		if child is LocationButton:
			child.connect("mouse_entered", self, "_on_mouse_entered_location", [child])
			child.connect("mouse_exited", self, "_on_mouse_exited_location", [child])
			child.connect("pressed", self, "_on_pressed_location", [child])

func _on_mouse_entered_location(location_button : LocationButton):
	emit_signal("mouse_entered_location", location_button.location)

func _on_mouse_exited_location(location_button : LocationButton):
	emit_signal("mouse_exited_location", location_button.location)

func _on_pressed_location(location_button : LocationButton):
	set_current_location(location_button.location)
	emit_signal("pressed_location", current_location)

func _ready():
	setup_signals()
