extends Control


onready var world_controller = $WorldController
onready var event_container = $HeaderUI/VBoxContainer/HBoxContainer2/EventContainer
onready var interactables_panel = $HeaderUI/VBoxContainer/HBoxContainer2/InteractablesPanel

func is_event_active():
	return event_container.get_child_count() > 0

func new_event(event_ui : EventUI):
	if is_event_active():
		return
	event_container.add_child(event_ui)

func _on_InteractablesPanel_pressed_interactable(interaction : int, interactable : InteractableData):
	var new_event_ui : EventUI
	match(interaction):
		InteractableData.interaction_types.LOOK:
			new_event_ui = interactable.get_look_event()
		InteractableData.interaction_types.USE:
			new_event_ui = interactable.get_use_event()
	if not new_event_ui == null:
		new_event(new_event_ui)

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
