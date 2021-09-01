extends Control


signal scene_changed(scene)

var start_game_scene = preload("res://Scenes/GameUI/GameUIv3.tscn")

func _on_CloseCreditsButton_pressed():
	$Credits.hide()

func _on_CreditsButton_pressed():
	$Credits.show()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	emit_signal("scene_changed", start_game_scene)
