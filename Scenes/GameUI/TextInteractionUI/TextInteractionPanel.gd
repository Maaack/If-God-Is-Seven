extends Panel


onready var log_label = $VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer/LogLabel
onready var interactions_container = $VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer/InteractionsContainer
onready var event_history_scroll = $VBoxContainer/MarginContainer/ScrollContainer
onready var event_write_delay_timer = $EventWriteDelayTimer
onready var time_label = $VBoxContainer/Panel/TimeLabel
onready var date_label = $VBoxContainer/Panel/DateLabel

enum day_periods {AM, PM}

var log_list : Array = []
var current_minute : int = 59
var current_hour : int = 8
var current_period : int = day_periods.AM
var current_day : int = 20

func add_text(append_text : String):
	log_label.text += "\n"
	yield(event_history_scroll, "draw")
	event_history_scroll.scroll_vertical += 16
	event_write_delay_timer.start()
	yield(event_write_delay_timer, "timeout")
	var full_log : String = "[06/%d %s] %s" % [current_day, _get_time_text(), append_text]
	log_list.append(append_text)
	var full_text : String = ""
	var first_flag : bool = true
	for log_text in log_list:
		if first_flag:
			first_flag = false
			full_text = log_text
			continue
		full_text += "\n%s" % log_text
	log_label.text = full_text

func _get_time_text():
	var display_hour = current_hour
	if display_hour == 0:
		display_hour = 12
	var display_period = "AM"
	if current_period == day_periods.PM:
		display_period = "PM"
	return "%02d:%02d %s" % [display_hour, current_minute, display_period]

func _update_time_display():
	time_label.text = _get_time_text()
	date_label.text = "June %d, 1986" % current_day

func add_time(minutes : int):
	var total_minute = current_minute + minutes
	var total_hour = current_hour + (total_minute / 60)
	current_minute = total_minute % 60
	current_period += total_hour / 12
	current_hour = total_hour % 12
	current_day += current_period / 2
	current_period %= 2
	_update_time_display()

