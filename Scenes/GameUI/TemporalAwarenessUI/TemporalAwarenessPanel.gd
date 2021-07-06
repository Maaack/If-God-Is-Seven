extends Panel


onready var event_history_label = $VBoxContainer/MarginContainer/ScrollContainer/EventHistoryLabel
onready var event_history_scroll = $VBoxContainer/MarginContainer/ScrollContainer
onready var event_write_delay_timer = $EventWriteDelayTimer
onready var time_label = $VBoxContainer/Panel/TimeLabel
onready var date_label = $VBoxContainer/Panel/DateLabel

enum day_periods {AM, PM}

var event_history : Array = []
var current_minute : int = 0
var current_hour : int = 9
var current_period : int = day_periods.AM
var current_day : int = 22

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

func add_time(hours : int, minutes : int):
	var total_hour = current_hour + hours
	var total_minute = current_minute + minutes
	total_hour += total_minute / 60
	current_minute = total_minute % 60
	current_period += total_hour / 12
	current_hour = total_hour % 12
	current_day += current_period / 2
	current_period %= 2
	var display_hour = current_hour
	if display_hour == 0:
		display_hour = 12
	var display_period = "AM"
	if current_period == day_periods.PM:
		display_period = "PM"
	time_label.text = "%02d:%02d %s" % [display_hour, current_minute, display_period]
	date_label.text = "June %d, 1986" % current_day

func _ready():
	add_event(event_history_label.text)
