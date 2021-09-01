extends Control


func _on_QuitButton_pressed():
	get_tree().quit()

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/GameUI/GameUI.tscn")
