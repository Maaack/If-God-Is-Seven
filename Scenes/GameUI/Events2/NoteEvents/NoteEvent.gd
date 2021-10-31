extends BaseEventUI


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			advance_event()

func _ready():
	start_event()
	if event_data is NoteEventData:
		var text_array : Array = event_data.note_text.split("\n")
		for text in text_array:
			add_note(text)
