extends Control


onready var historic_text_animations_player = $AnimationPlayer

var historical_text_visibility : bool = false

func show_historical_text(value : bool):
	var time_to_end : float = 0.0
	if historic_text_animations_player.is_playing():
		time_to_end = historic_text_animations_player.current_animation_length - historic_text_animations_player.current_animation_position
	if value and not historical_text_visibility:
		historic_text_animations_player.play("HistoricTextFadeIn")
	elif not value and historical_text_visibility:
		historic_text_animations_player.play("HistoricTextFadeOut")
	historical_text_visibility = value
	if historic_text_animations_player.is_playing():
		historic_text_animations_player.seek(time_to_end)

func add_text(event_text : String):
	$CurrentTextLabel.add_text(event_text)

func add_time(minutes : int):
	$HistoricTextPanel.add_time(minutes)

func _on_CurrentTextLabel_next_text_displayed(text):
	$HistoricTextPanel.add_text(text)

func _on_HistoricTextPanel_mouse_entered():
	show_historical_text(true)

