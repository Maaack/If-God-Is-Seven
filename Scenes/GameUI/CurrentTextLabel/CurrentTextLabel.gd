extends Label


export(float) var base_wait_time = 1.0
export(float) var word_wait_time = 0.4
var text_buffer : Array = []

func _display_next_text():
	if text_buffer.size() < 1:
		return
	var next_text : String = text_buffer.pop_front()
	var word_count : int = next_text.split(" ").size()
	text = next_text
	$TextWaitTimer.wait_time = base_wait_time + (word_wait_time * word_count)
	$TextWaitTimer.start()

func add_text(value : String):
	text_buffer.append(value)
	if $TextWaitTimer.is_stopped():
		$TextWaitTimer.start()

func _on_TextWaitTimer_timeout():
	text = ""
	_display_next_text()
