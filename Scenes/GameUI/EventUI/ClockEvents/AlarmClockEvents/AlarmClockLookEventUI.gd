extends "res://Scenes/GameUI/EventUI/ClockEvents/ClockLookEventUI.gd"


onready var flashing_time_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyLabel/FlashingTimeLabel
onready var flash_timer = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/FlashTimer

func _on_FlashTimer_timeout():
	time_label.visible = !bool(time_label.visible)

func _ready():
	if source_interactable.alarm_ringing:
		flash_timer.start()
		flashing_time_label.show()
