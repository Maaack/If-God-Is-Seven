extends Control


onready var world_controller = $WorldController
onready var subtitle_ui = $BottomFilmBar/SubtitleUI
onready var event_container = $MarginContainer2/EventContainer
onready var button_container_node = $ButtonContainer
onready var travel_panel = $TravelPanel
onready var interactions_animations_player = $MarginContainer/InteractionsPanel/AnimationPlayer
onready var fade_out_timer = $MarginContainer/InteractionsPanel/FadeOutTimer

export(Resource) var current_location : Resource
export(Resource) var first_event : Resource

var interaction_type : int = InteractionConstants.interaction_types.POINT setget set_interaction_type
var interactions_visibility : bool = true
var interactions_force_show : bool = true
var button_scene = preload("res://Scenes/SceneEditor/SceneInteractableButton.tscn")
var interactable_button_map : Dictionary = {}
var interaction_types_available : Array = []

func _hide_hint_1():
	$HintArrow.fade_out()

func _clear_buttons():
	interactable_button_map.clear()
	interaction_types_available = [InteractionConstants.interaction_types.TRAVEL]
	if button_container_node == null:
		return
	for child in button_container_node.get_children():
		child.queue_free()

func _force_mouse_cursor_pointer():
	if $MouseCursor == null:
		return
	$MouseCursor.set_interaction_type(InteractionConstants.interaction_types.POINT)

func is_event_active():
	return event_container.get_child_count() > 0

func get_active_event():
	if not is_event_active():
		return
	return event_container.get_child(0)

func _update_mouse_cursor():
	if $MouseCursor == null:
		return
	if is_event_active():
		return
	$MouseCursor.set_interaction_type(interaction_type)

func _update_background():
	if $TextureRect == null:
		return
	$TextureRect.texture = current_location.background


func _update_map():
	$TravelPanel/TravelUI.set_current_location(current_location)
	
func _update_interaction_types_button_visibility():
	$MarginContainer/InteractionsPanel.update_interactions_available(interaction_types_available)

func _update_button_visibilty():
	if button_container_node == null:
		return
	if is_event_active():
		button_container_node.hide()
		return
	else:
		button_container_node.show()
	for interactable in interactable_button_map:
		var button_instance : Control = interactable_button_map[interactable]
		if interactable is InteractableData:
			if interactable.is_interactable(interaction_type):
				button_instance.visible = true
				if interactable.has_interacted(interaction_type):
					button_instance.set_gray(true)
				else:
					button_instance.set_gray(false)
			else:
				button_instance.visible = false
	if travel_panel == null:
		return
	if interaction_type == InteractionConstants.interaction_types.TRAVEL:
		travel_panel.show()
	else:
		travel_panel.hide()

func _cycle_interaction():
	interaction_type += 1
	while(not interaction_type in interaction_types_available):
		interaction_type += 1
		if interaction_type >= InteractionConstants.interaction_types.size():
			interaction_type = 0
	$MarginContainer/InteractionsPanel.update_interaction_type_set(interaction_type)
	set_interaction_type(interaction_type)

func refresh():
	_hide_hint_1()
	_update_mouse_cursor()
	_update_button_visibilty()

func end_event():
	var event_ui = get_active_event()
	if event_ui == null:
		return
	event_ui.queue_free()
	refresh()

func new_base_event(event_ui : BaseEventUI):
	if is_event_active():
		return
	event_ui.connect("added_time", world_controller, "add_time")
	event_ui.connect("added_note", self, "_add_subtitle")
	event_ui.connect("advanced_event", self, "_advance_subtitle")
	event_ui.connect("ended_event", self, "end_event")
	event_ui.connect("tree_exited", self, "refresh")
	event_container.add_child(event_ui)
	_force_mouse_cursor_pointer()
	_update_button_visibilty()

func run_interaction(interactable : InteractableData, custom_interaction_type : int = interaction_type):
	var new_event_ui = interactable.get_event_ui(custom_interaction_type)
	if new_event_ui == null:
		return
	if new_event_ui is BaseEventUI:
		new_event_ui.interactable_data = interactable
		new_event_ui.interaction_type = interaction_type
		new_base_event(new_event_ui)

func _on_InteractableButton_pressed(interactable : InteractableData):
	run_interaction(interactable)

func _update_buttons():
	if button_container_node == null:
		return
	for interactable in current_location.interactables:
		if interactable is InteractableData:
			var button_instance = button_scene.instance()
			button_container_node.add_child(button_instance)
			button_instance.set_owner(get_tree().edited_scene_root)
			button_instance.text = interactable.title
			button_instance.set_position(interactable.scene_position)
			button_instance.connect("pressed", self, "_on_InteractableButton_pressed", [interactable])
			interactable_button_map[interactable] = button_instance
			interaction_types_available.append_array(interactable.interactions_array)
	_update_button_visibilty()
	_update_interaction_types_button_visibility()

func set_interaction_type(value : int):
	interaction_type = value
	if interaction_type == null:
		return
	refresh()

func set_location(value : LocationData):
	current_location = value
	_clear_buttons()
	if current_location == null:
		return
	_update_background()
	_update_buttons()
	_update_map()

func show_interactions_menu(value : bool):
	if value:
		fade_out_timer.stop()
	var time_to_end : float = 0.0
	if interactions_animations_player.is_playing():
		time_to_end = interactions_animations_player.current_animation_length - interactions_animations_player.current_animation_position
	if value and not interactions_visibility:
		interactions_animations_player.play("FadeIn")
		interactions_animations_player.seek(time_to_end)
	elif not value and interactions_visibility:
		interactions_animations_player.play("FadeOut")
		interactions_animations_player.seek(time_to_end)
	interactions_visibility = value

func _advance_subtitle():
	subtitle_ui.advance_text()

func _add_subtitle(value : String):
	subtitle_ui.add_text(value)

func _ready():
	var travel_ui = $TravelPanel/TravelUI
	travel_ui.current_map = world_controller.get_current_map()
	travel_ui.current_location = world_controller.get_current_location()
	world_controller.add_time(1)
	set_location(current_location)
	_update_mouse_cursor()
	run_interaction(first_event, InteractionConstants.interaction_types.LOOK)

func _on_WorldController_added_time(minutes):
	subtitle_ui.add_time(minutes)

func _on_FadeOutTimer_timeout():
	show_interactions_menu(false)

func _on_TravelUI_pressed_location(location):
	world_controller.travel_to(location)
	set_location(location)
	_add_subtitle("You enter %s." % location.title.to_lower())

func _on_InteractionsPanel_changed_interaction(interaction : int):
	set_interaction_type(interaction)

func _handle_mouse_motion(event : InputEventMouseMotion):
		if event.position.x < 50:
			show_interactions_menu(true)
			interactions_force_show = false
		elif not interactions_force_show and interactions_visibility and fade_out_timer.is_stopped():
			fade_out_timer.start()
		subtitle_ui.show_historical_text(event.position.y > get_rect().size.y - 50)

func _input(event):
	if event is InputEventMouseMotion:
		_handle_mouse_motion(event)
	elif event.is_action_pressed("ui_cycle_interaction"):
		_cycle_interaction()

func _on_SubtitleUI_finished_display_text():
	var event_ui = get_active_event()
	if event_ui == null:
		return
	if event_ui.has_method("on_subtitle_finish_displaying"):
		event_ui.on_subtitle_finish_displaying()
