extends BaseEventUI


class_name NoteEvent

func start_event():
	.start_event()
	var text_array : Array = interactable_data.note_text.split("\n")
	for text in text_array:
		add_note(text)

func on_subtitle_finish_displaying():
	end_event()
