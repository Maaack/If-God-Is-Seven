extends Panel


onready var event_history_label = $MarginContainer/VBoxContainer/ScrollContainer/EventHistoryLabel
onready var event_history_scroll = $MarginContainer/VBoxContainer/ScrollContainer
onready var event_write_delay_timer = $EventWriteDelayTimer

var event_history : Array = []

func add_event(event_text : String):
	var text : String = ""
	for event in event_history:
		text += event + "\n"
	event_history_label.text = text
	yield(event_history_scroll, "draw")
	event_history_scroll.scroll_vertical += 16
	event_write_delay_timer.start()
	yield(event_write_delay_timer, "timeout")
	event_history_label.text += event_text
	event_history.append(event_text)
	

func _ready():
	add_event(event_history_label.text)
