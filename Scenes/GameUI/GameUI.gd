extends Control


onready var world_controller = $WorldController
onready var event_container = $HeaderUI/VBoxContainer/HBoxContainer2/EventContainer
onready var interactables_panel = $HeaderUI/VBoxContainer/HBoxContainer2/InteractablesPanel
var event_ui_scene = preload("res://Scenes/GameUI/EventUI/EventUI.tscn")

func is_event_active():
	return event_container.get_child_count() > 0

func new_event(event_data : EventData):
	if is_event_active():
		return
	var event_ui_instance = event_ui_scene.instance()
	event_ui_instance.starting_event = event_data
	event_container.add_child(event_ui_instance)

func _on_InteractablesPanel_pressed_interactable(interaction : int, interactable : InteractableData):
	var new_event_data : EventData
	match(interaction):
		InteractableData.interaction_types.LOOK:
			new_event_data = interactable.get_look_event()
	if not new_event_data == null:
		new_event(new_event_data)

func _on_InteractablesPanel_pressed_location(location):
	if is_event_active():
		return
	world_controller.travel_to(location)
	interactables_panel.current_location = location
	$Background.texture = location.background
	$HeaderUI/VBoxContainer/HBoxContainer/TemporalAwarenessPanel.add_event("You enter %s" % location.title.to_upper())

func _ready():
	interactables_panel.current_map = world_controller.get_current_map()
	interactables_panel.current_location = world_controller.get_current_location()

func _on_WorldController_added_time(minutes):
	$HeaderUI/VBoxContainer/HBoxContainer/TemporalAwarenessPanel.add_time(minutes)
