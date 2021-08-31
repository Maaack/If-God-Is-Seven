extends ClockEventUI


class_name AlarmClockEventUI


onready var separator_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/SeparatorLabel
onready var alarm_checkbox = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/AlarmCheckBox

var edit_alarm_mode : bool = false

func set_source_interactable(value : InteractableData):
	if not value is AlarmClockInteractableData:
		print("Was not AlarmClockInteractableData")
		return
	source_interactable = value

func get_alarm_period_string():
	if source_interactable.alarm_period == ClockInteractableData.day_periods.PM:
		return "PM"
	else:
		return "AM"

func get_alarm_hour_string():
	var current_hour : int = source_interactable.alarm_hour
	if current_hour == 0:
		current_hour = 12
	return "%02d" % current_hour

func get_alarm_minute_string():
	return "%02d" % source_interactable.alarm_minute

func get_alarm_time_string():
	return "%s:%s %s" % [get_alarm_hour_string(), get_alarm_minute_string(), get_alarm_period_string()]

func add_alarm_hours(hours : int):
	source_interactable.add_alarm_hours(hours)

func add_alarm_minutes(minutes : int):
	source_interactable.add_alarm_minutes(minutes)

func add_alarm_periods(periods : int):
	source_interactable.add_alarm_periods(periods)

func _update_time_labels():
	if edit_alarm_mode:
		hour_label.text = get_alarm_hour_string()
		minute_label.text = get_alarm_minute_string()
		period_label.text = get_alarm_period_string()
	else:
		hour_label.text = get_hour_string()
		minute_label.text = get_minute_string()
		period_label.text = get_period_string()

func toggle_edit_alarm():
	edit_alarm_mode = !(edit_alarm_mode)
	alarm_checkbox.pressed = edit_alarm_mode
	_update_time_labels()

func _get_flashing_flavor_text() -> String:
	if source_interactable.alarm_ringing:
		return "The clock face is flashing."
	return ""

func _get_ringing_flavor_text() -> String:
	if source_interactable.alarm_ringing:
		return "The clock alarm is buzzing loudly."
	return ""

func _get_flavor_text() -> String:
	match(get_interaction_type()):
		InteractionConstants.interaction_types.LOOK:
			return _get_flashing_flavor_text()
		InteractionConstants.interaction_types.LISTEN:
			return _get_ringing_flavor_text()
	return ""

func _refresh_body_text():
	body_label.text = get_body_text() % [get_look_time(), _get_flavor_text()]

func _ready():
	alarm_checkbox.pressed = source_interactable.alarm_ringing

func _flash_full_face():
	hour_label.visible = !bool(hour_label.visible)
	minute_label.visible = hour_label.visible
	period_label.visible = hour_label.visible
	separator_label.visible = hour_label.visible
	alarm_checkbox.pressed = hour_label.visible

func _on_FlashTimer_timeout():
	if source_interactable.alarm_ringing:
		_flash_full_face()
	else:
		_flash_current_stage()

func _on_ModButton_pressed():
	if source_interactable.alarm_ringing:
		source_interactable.alarm_ringing = false
		emit_signal("added_historical_note", "You silenced the ALARM CLOCK.")
		end_event()
	else:
		match(current_use_stage):
			INIT_STAGE:
				toggle_edit_alarm()
			HOUR_STAGE:
				if not edit_alarm_mode:
					add_hours(1)
					hour_label.text = get_hour_string()
				else:
					add_alarm_hours(1)
					hour_label.text = get_alarm_hour_string()
			MINUTE_STAGE:
				if not edit_alarm_mode:
					add_minutes(1)
					minute_label.text = get_minute_string()
				else:
					add_alarm_minutes(1)
					minute_label.text = get_alarm_minute_string()
			PERIOD_STAGE:
				if not edit_alarm_mode:
					add_periods(1)
					period_label.text = get_period_string()
				else:
					add_alarm_periods(1)
					period_label.text = get_alarm_period_string()
		_reset_flashing()

func _on_SetButton_pressed():
	if source_interactable.alarm_ringing:
		source_interactable.alarm_ringing = false
		source_interactable.alarm_snoozing = true
		emit_signal("added_historical_note", "You snoozed the ALARM CLOCK.")
		end_event()
	else:
		current_use_stage += 1
		continue_button.hide()
		_reset_flashing()
		_flash_current_stage()
		if current_use_stage > PERIOD_STAGE:
			if not edit_alarm_mode:
				emit_signal("added_historical_note", "You set the ALARM CLOCK's time to %s." % get_time_string())
			else:
				emit_signal("added_historical_note", "You set the ALARM CLOCK's alarm time to %s." % get_alarm_time_string())
			emit_signal("attempted_waiting", 1)
			end_event()

