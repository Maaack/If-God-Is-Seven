extends Control


onready var world_controller = $WorldController
onready var subtitle_ui = $BottomFilmBar/SubtitleUI
onready var travel_ui = $TravelPanel/TravelUI
onready var interactions_animations_player = $MarginContainer/MouseReactArea/InteractionsPanel/AnimationPlayer
onready var fade_out_timer = $MarginContainer/MouseReactArea/InteractionsPanel/FadeOutTimer

export(Resource) var start_location : Resource
var interactions_visibility : bool = true
var button_scene = preload("res://Scenes/SceneEditor/SceneInteractableButton.tscn")

func set_location(value : LocationData):
	var button_container_node = $ButtonContainer
	start_location = value
	if button_container_node != null:
		for child in button_container_node.get_children():
			child.queue_free()
	if start_location == null:
		return
	if $TextureRect != null:
		$TextureRect.texture = start_location.background
	if button_container_node != null:
		for interactable in start_location.interactables:
			if interactable is InteractableData:
				var button_instance = button_scene.instance()
				button_container_node.add_child(button_instance)
				button_instance.set_owner(get_tree().edited_scene_root)
				button_instance.text = interactable.title
				button_instance.set_position(interactable.scene_position)
				button_instance.connect("item_rect_changed", self, "_update_interactable_by_button", [interactable, button_instance])

func show_interactions(value : bool):
	var time_to_end : float = 0.0
	if interactions_animations_player.is_playing():
		time_to_end = interactions_animations_player.current_animation_length - interactions_animations_player.current_animation_position
	if value and not interactions_visibility:
		interactions_animations_player.play("FadeIn")
	elif not value and interactions_visibility:
		interactions_animations_player.play("FadeOut")
	interactions_visibility = value
	if interactions_animations_player.is_playing():
		interactions_animations_player.seek(time_to_end)

func _add_story_text(value : String):
	subtitle_ui.add_text(value)

func _ready():
	travel_ui.current_map = world_controller.get_current_map()
	travel_ui.current_location = world_controller.get_current_location()
	world_controller.add_time(1)
	set_location(start_location)
	_add_story_text("Something happens and you insta die!")
	_add_story_text("Oh well...")

func _on_WorldController_added_time(minutes):
	subtitle_ui.add_time(minutes)

func _on_MouseReactArea_mouse_entered():
	fade_out_timer.stop()
	show_interactions(true)

func _on_MouseReactArea_mouse_exited():
	fade_out_timer.start()

func _on_FadeOutTimer_timeout():
	show_interactions(false)

func _on_TravelUI_pressed_location(location):
	world_controller.travel_to(location)
	set_location(location)
	_add_story_text("You enter %s" % location.title)

func _on_TextureRect_mouse_entered():
	subtitle_ui.show_historical_text(false)

