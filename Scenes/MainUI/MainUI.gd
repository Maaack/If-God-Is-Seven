extends Control


func _on_CloseCreditsButton_pressed():
	$Credits.hide()

func _on_CreditsButton_pressed():
	$Credits.show()

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/GameUI/GameUI.tscn")
