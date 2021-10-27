extends EventUI


class_name BasicEventUI

export(String, MULTILINE) var event_text : String = ""

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			end_event()

func _ready():
	var event_text_array = event_text.split("\n")
	for text in event_text_array:
		log_event_text(text)

func _on_Timer_timeout():
	end_event()
