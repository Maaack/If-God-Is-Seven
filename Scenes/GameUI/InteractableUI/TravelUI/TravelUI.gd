extends Control


signal pressed_location(location)

export(PackedScene) var current_map : PackedScene setget set_current_map
export(Resource) var current_location : Resource setget set_current_location

onready var map_container = $VBoxContainer/MapContainer
onready var travel_label = $VBoxContainer/TravelLabel

var map_instance

func set_current_map(value : PackedScene):
	if value == current_map:
		return
	current_map = value
	if is_instance_valid(map_instance):
		map_instance.queue_free()
	if current_map is PackedScene:
		map_instance = current_map.instance()
		map_container.add_child(map_instance)
		map_instance.current_location = current_location
		map_instance.connect("mouse_entered_location", self, "_on_MapControl_mouse_entered_location")
		map_instance.connect("mouse_exited_location", self, "_on_MapControl_mouse_exited_location")
		map_instance.connect("pressed_location", self, "_on_MapControl_pressed_location")

func set_current_location(value : LocationData):
	if value == current_location:
		return
	current_location = value
	if not is_instance_valid(map_instance) or not map_instance is InteractableMap:
		return
	map_instance.current_location = current_location

func _on_MapControl_mouse_entered_location(location : LocationData):
	if location == current_location:
		return
	travel_label.text = "Go to %s" % location.title

func _on_MapControl_mouse_exited_location(location):
	travel_label.text = "Go to..."

func _on_MapControl_pressed_location(location):
	emit_signal("pressed_location", location)

