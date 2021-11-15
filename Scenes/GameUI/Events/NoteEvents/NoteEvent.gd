extends BaseEventUI


class_name NoteEvent

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			advance_event()

func _ready():
	start_event()
	var text_array : Array = interactable_data.note_text.split("\n")
	for text in text_array:
		add_note(text)

func on_subtitle_finish_displaying():
	end_event()
