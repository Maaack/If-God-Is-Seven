extends Label


signal next_text_displayed(text)

export(float) var base_wait_time = 1.0
export(float) var word_wait_time = 0.25
var text_buffer : Array = []

func _can_display_next_text():
	return $TextWaitTimer.is_stopped() and $TextClearTimer.is_stopped()

func _display_next_text():
	if text_buffer.size() < 1:
		return
	var next_text : String = text_buffer.pop_front()
	var word_count : int = next_text.split(" ").size()
	text = next_text
	$TextWaitTimer.wait_time = base_wait_time + (word_wait_time * word_count)
	$TextWaitTimer.start()
	emit_signal("next_text_displayed", next_text)

func add_text(value : String):
	text_buffer.append(value)
	if _can_display_next_text():
		_display_next_text()

func _on_TextWaitTimer_timeout():
	text = ""
	$TextClearTimer.start()

func _on_TextClearTimer_timeout():
	_display_next_text()
