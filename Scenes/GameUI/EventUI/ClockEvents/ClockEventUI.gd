extends EventUI


class_name ClockEventUI


onready var hour_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/HourLabel
onready var minute_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/MinuteLabel
onready var period_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/PeriodLabel
onready var flash_timer = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/FlashTimer

enum {INIT_STAGE, HOUR_STAGE, MINUTE_STAGE, PERIOD_STAGE}

var current_use_stage : int = INIT_STAGE

func set_source_interactable(value : InteractableData):
	if not value is ClockInteractableData:
		print("Was not ClockInteractableData")
		return
	source_interactable = value

func get_period_string():
	if source_interactable.current_period == ClockInteractableData.day_periods.PM:
		return "PM"
	else:
		return "AM"

func get_hour_string():
	var current_hour : int = source_interactable.current_hour
	if current_hour == 0:
		current_hour = 12
	return "%02d" % current_hour

func get_minute_string():
	return "%02d" % source_interactable.current_minute

func get_time_string():
	return "%s:%s %s" % [get_hour_string(), get_minute_string(), get_period_string()]

func add_hours(hours : int):
	source_interactable.add_hours(hours)

func add_minutes(minutes : int):
	source_interactable.add_minutes(minutes)

func add_periods(periods : int):
	source_interactable.add_periods(periods)

func get_look_time():
	return "%s:%s %s" % [get_hour_string(), get_minute_string(), get_period_string()]

func _refresh_clock_face():
	hour_label.text = get_hour_string()
	minute_label.text = get_minute_string()
	period_label.text = get_period_string()	

func _refresh_body_text():
	body_label.text = get_body_text() % [get_look_time()]

func refresh():
	_refresh_clock_face()
	_refresh_body_text()

func _ready():
	refresh()

func _reset_flashing():
	hour_label.show()
	minute_label.show()
	period_label.show()
	flash_timer.start()

func _flash_current_stage():
	match(current_use_stage):
		HOUR_STAGE:
			hour_label.visible = !bool(hour_label.visible)
		MINUTE_STAGE:
			minute_label.visible = !bool(minute_label.visible)
		PERIOD_STAGE:
			period_label.visible = !bool(period_label.visible)

func _on_FlashTimer_timeout():
	_flash_current_stage()

func _on_ModButton_pressed():
	match(current_use_stage):
		HOUR_STAGE:
			add_hours(1)
			hour_label.text = get_hour_string()
		MINUTE_STAGE:
			add_minutes(1)
			minute_label.text = get_minute_string()
		PERIOD_STAGE:
			add_periods(1)
			period_label.text = get_period_string()
	_reset_flashing()

func _on_SetButton_pressed():
	current_use_stage += 1
	continue_button.hide()
	_reset_flashing()
	_flash_current_stage()
	if current_use_stage > PERIOD_STAGE:
		emit_signal("added_historical_note", "You set the time to %s." % get_time_string())
		emit_signal("attempted_waiting", 1)
		end_event()
