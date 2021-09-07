extends Control


onready var world_controller = $WorldController
onready var event_container = $HeaderUI/VBoxContainer/HBoxContainer2/EventContainer
onready var interactables_panel = $HeaderUI/VBoxContainer/HBoxContainer2/InteractablesPanel
onready var temporal_awareness_panel = $HeaderUI/VBoxContainer/HBoxContainer/TemporalAwarenessPanel

func is_event_active():
	return event_container.get_child_count() > 0

func new_event(event_ui : EventUI):
	if is_event_active():
		return
	event_ui.connect("attempted_waiting", world_controller, "add_time")
	event_ui.connect("logged_event", temporal_awareness_panel, "add_event")
	event_ui.connect("ended_event", self, "refresh")
	event_container.add_child(event_ui)

func refresh():
	interactables_panel.refresh()

func _on_InteractablesPanel_pressed_interactable(interaction : int, interactable : InteractableData):
	var new_event_ui : EventUI = interactable.get_event_ui(interaction)
	if not new_event_ui == null:
		new_event(new_event_ui)

func _on_InteractablesPanel_pressed_location(location):
	if is_event_active():
		return
	world_controller.travel_to(location)
	interactables_panel.current_location = location
	$Background.texture = location.background
	temporal_awareness_panel.add_event("You enter %s" % location.title.to_upper())

func _ready():
	interactables_panel.current_map = world_controller.get_current_map()
	interactables_panel.current_location = world_controller.get_current_location()
	world_controller.add_time(1)

func _on_WorldController_added_time(minutes):
	temporal_awareness_panel.add_time(minutes)
	refresh()
