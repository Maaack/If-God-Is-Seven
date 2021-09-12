extends Control


onready var world_controller = $WorldController
onready var subtitle_ui = $BottomFilmBar/SubtitleUI
onready var event_container = $MarginContainer2/EventContainer
onready var button_container_node = $ButtonContainer
onready var travel_panel = $TravelPanel
onready var interactions_animations_player = $MarginContainer/InteractionsPanel/AnimationPlayer
onready var fade_out_timer = $MarginContainer/InteractionsPanel/FadeOutTimer

export(Resource) var current_location : Resource
export(InteractionConstants.interaction_types) var interaction_type : int = InteractionConstants.interaction_types.LOOK setget set_interaction_type

var interactions_visibility : bool = true
var interactions_force_show : bool = true
var button_scene = preload("res://Scenes/SceneEditor/SceneInteractableButton.tscn")
var interactable_button_map : Dictionary = {}

func _clear_buttons():
	interactable_button_map.clear()
	if button_container_node == null:
		return
	for child in button_container_node.get_children():
		child.queue_free()

func _force_mouse_cursor_pointer():
	if $MouseCursor == null:
		return
	$MouseCursor.set_interaction_type(InteractionConstants.interaction_types.POINT)	

func _update_mouse_cursor():
	if $MouseCursor == null:
		return
	$MouseCursor.set_interaction_type(interaction_type)

func _update_background():
	if $TextureRect == null:
		return
	$TextureRect.texture = current_location.background

func is_event_active():
	return event_container.get_child_count() > 0

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

func refresh():
	_update_mouse_cursor()
	_update_button_visibilty()

func new_event(event_ui : EventUI):
	if is_event_active():
		return
	event_ui.connect("attempted_waiting", world_controller, "add_time")
	event_ui.connect("logged_event", self, "_add_subtitle")
	event_ui.connect("ended_event", self, "refresh")
	event_ui.connect("tree_exited", self, "refresh")
	event_container.add_child(event_ui)
	_force_mouse_cursor_pointer()
	_update_button_visibilty()

func _on_InteractableButton_pressed(interactable : InteractableData):
	var new_event_ui : EventUI = interactable.get_event_ui(interaction_type)
	if not new_event_ui == null:
		new_event(new_event_ui)

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
	_update_button_visibilty()

func set_interaction_type(value : int):
	interaction_type = value
	if interaction_type == null:
		return
	_update_mouse_cursor()
	_update_button_visibilty()

func set_location(value : LocationData):
	current_location = value
	_clear_buttons()
	if current_location == null:
		return
	_update_background()
	_update_buttons()

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

func _add_subtitle(value : String):
	subtitle_ui.add_text(value)

func _ready():
	var travel_ui = $TravelPanel/TravelUI
	travel_ui.current_map = world_controller.get_current_map()
	travel_ui.current_location = world_controller.get_current_location()
	world_controller.add_time(1)
	set_location(current_location)
	_add_subtitle("You stir from your sleep...")
	_add_subtitle("The alarm clock is buzzing loudly!")

func _on_WorldController_added_time(minutes):
	subtitle_ui.add_time(minutes)

func _on_FadeOutTimer_timeout():
	show_interactions_menu(false)

func _on_TravelUI_pressed_location(location):
	world_controller.travel_to(location)
	set_location(location)
	_add_subtitle("You enter %s" % location.title)

func _on_InteractionsPanel_changed_interaction(interaction : int):
	set_interaction_type(interaction)

func _input(event):
	if event is InputEventMouseMotion:
		if event.position.x < 50:
			show_interactions_menu(true)
			interactions_force_show = false
		elif not interactions_force_show and interactions_visibility and fade_out_timer.is_stopped():
			fade_out_timer.start()
		subtitle_ui.show_historical_text(event.position.y > get_rect().size.y - 50)
