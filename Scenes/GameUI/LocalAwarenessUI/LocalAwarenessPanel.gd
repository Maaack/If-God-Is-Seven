extends Panel


signal changed_location(location)

export(PackedScene) var current_map : PackedScene
export(Resource) var current_location : Resource

onready var map_container = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/MapContainer
onready var location_label = $VBoxContainer/HeaderPanel/LocationLabel
onready var travel_label = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/TravelLabel
onready var interactables_container = $InteractablesPanel/MarginContainer/HBoxContainer/InteractablesContainer

var interactable_button_scene = preload("res://Scenes/GameUI/LocalAwarenessUI/InteractableButton.tscn")
var map_instance

func update_interactables():
	for child in interactables_container.get_children():
		child.queue_free()
	if not current_location is LocationData:
		return
	for interactable in current_location.interactables:
		var interactable_button_instance = interactable_button_scene.instance()
		interactables_container.add_child(interactable_button_instance)
		interactable_button_instance.text = interactable.title

func update_map():
	if is_instance_valid(map_instance):
		map_instance.queue_free()
	if current_map is PackedScene:
		map_instance = current_map.instance()
		map_container.add_child(map_instance)
		map_instance.current_location = current_location
		map_instance.connect("mouse_entered_location", self, "_on_MapControl_mouse_entered_location")
		map_instance.connect("mouse_exited_location", self, "_on_MapControl_mouse_exited_location")
		map_instance.connect("pressed_location", self, "_on_MapControl_pressed_location")

func update_location():
	if current_location is LocationData:
		location_label.text = "%s - %s" % [map_instance.title, current_location.title]
	else:
		location_label.text = "%s" % map_instance.title
	update_interactables()

func _ready():
	update_map()
	update_location()

func _on_MapControl_mouse_entered_location(location : LocationData):
	if location == current_location:
		return
	travel_label.text = "Go to %s" % location.title

func _on_MapControl_mouse_exited_location(location):
	travel_label.text = "Go to..."

func _on_MapControl_pressed_location(location):
	if location == current_location:
		return
	current_location = location
	update_location()
	emit_signal("changed_location", current_location)
