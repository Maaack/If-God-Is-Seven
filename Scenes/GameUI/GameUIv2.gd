extends Control


onready var world_controller = $WorldController
onready var text_interactable_panel = $BottomFilmBar/TextInteractionPanel
onready var interactions_animations_player = $MarginContainer/MouseReactArea/InteractionsPanel/AnimationPlayer
onready var fade_out_timer = $MarginContainer/MouseReactArea/InteractionsPanel/FadeOutTimer

enum visibility_settings{FADE_OUT, FADE_IN, SHOW}
var interactions_visibility : bool = true

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

func _ready():
	world_controller.add_time(1)

func _on_WorldController_added_time(minutes):
	text_interactable_panel.add_time(minutes)

func _on_MouseReactArea_mouse_entered():
	fade_out_timer.stop()
	show_interactions(true)

func _on_MouseReactArea_mouse_exited():
	fade_out_timer.start()

func _on_FadeOutTimer_timeout():
	show_interactions(false)
