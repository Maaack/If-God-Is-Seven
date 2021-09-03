extends Control


signal scene_changed(scene)

var start_game_scene = preload("res://Scenes/GameUI/GameUIv3.tscn")
var click_counter = 0
var ff_clicks_threshold = 2

func _on_CloseCreditsButton_pressed():
	$Credits.hide()

func _on_CreditsButton_pressed():
	$Credits.show()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	emit_signal("scene_changed", start_game_scene)

func _fast_forward_animations():
	$BlackoutFilmBars/AnimationPlayer.seek(8)
	$Panel/AnimationPlayer.seek(8)
	$Panel2/AnimationPlayer.seek(8)
	$VBoxContainer/AnimationPlayer.seek(8)

func _on_MouseDetect_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			click_counter += 1
			if click_counter >= ff_clicks_threshold:
				_fast_forward_animations()
