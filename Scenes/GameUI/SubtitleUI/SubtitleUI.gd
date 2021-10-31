extends Control

signal finished_display_text

onready var historic_text_animations_player = $AnimationPlayer

var historical_text_visibility : bool = false

func show_historical_text(value : bool):
	var time_to_end : float = 0.0
	if historic_text_animations_player.is_playing():
		time_to_end = historic_text_animations_player.current_animation_length - historic_text_animations_player.current_animation_position
	if value and not historical_text_visibility:
		historic_text_animations_player.play("HistoricTextFadeIn")
		historic_text_animations_player.seek(time_to_end)
	elif not value and historical_text_visibility:
		historic_text_animations_player.play("HistoricTextFadeOut")
		historic_text_animations_player.seek(time_to_end)
	historical_text_visibility = value

func add_text(event_text : String):
	$CurrentTextLabel.add_text(event_text)

func add_time(minutes : int):
	$HistoricTextPanel.add_time(minutes)

func _on_CurrentTextLabel_next_text_displayed(text):
	$HistoricTextPanel.add_text(text)

func advance_text():
	$CurrentTextLabel.advance_text()

func _on_CurrentTextLabel_finished_displaying_text():
	emit_signal("finished_display_text")
