extends ClockEvent


class_name AlarmClockEvent

onready var alarm_checkbox = $CenterContainer/EventPanel/MarginContainer/VBoxContainer/BodyContainer/CenterContainer/Panel/AlarmCheckBox

var edit_alarm_mode : bool = false

func get_alarm_period_string():
	if interactable_data.alarm_period == ClockInteractableData.day_periods.PM:
		return "PM"
	else:
		return "AM"

func get_alarm_hour_string():
	var current_hour : int = interactable_data.alarm_hour
	if current_hour == 0:
		current_hour = 12
	return "%02d" % current_hour

func get_alarm_minute_string():
	return "%02d" % interactable_data.alarm_minute

func get_alarm_time_string():
	return "%s:%s %s" % [get_alarm_hour_string(), get_alarm_minute_string(), get_alarm_period_string()]

func add_alarm_hours(hours : int):
	interactable_data.add_alarm_hours(hours)

func add_alarm_minutes(minutes : int):
	interactable_data.add_alarm_minutes(minutes)

func add_alarm_periods(periods : int):
	interactable_data.add_alarm_periods(periods)

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
	if interactable_data.alarm_ringing:
		return "The clock face is flashing."
	return ""

func _get_ringing_flavor_text() -> String:
	if interactable_data.alarm_ringing:
		return "The clock alarm is buzzing loudly."
	return ""

func _get_flavor_text() -> String:
	match(interaction_type):
		InteractionConstants.interaction_types.LOOK:
			return _get_flashing_flavor_text()
		InteractionConstants.interaction_types.LISTEN:
			return _get_ringing_flavor_text()
	return ""

func _refresh_clock_face():
	._refresh_clock_face()

func start_event():
	.start_event()
	add_note(_get_flavor_text())
	alarm_checkbox.pressed = interactable_data.alarm_ringing

func _flash_full_face():
	hour_label.visible = !bool(hour_label.visible)
	minute_label.visible = hour_label.visible
	period_label.visible = hour_label.visible
	separator_label.visible = hour_label.visible
	alarm_checkbox.pressed = hour_label.visible

func _on_FlashTimer_timeout():
	if interactable_data.alarm_ringing:
		_flash_full_face()
	else:
		_flash_current_stage()

func _on_ModButton_pressed():
	if interactable_data.alarm_ringing:
		interactable_data.alarm_ringing = false
		add_note("You silenced the alarm clock.")
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
	if interactable_data.alarm_ringing:
		interactable_data.alarm_ringing = false
		interactable_data.alarm_snoozing = true
		add_note("You snoozed the alarm clock.")
		end_event()
	else:
		current_use_stage += 1
		continue_button.hide()
		_reset_flashing()
		_flash_current_stage()
		if current_use_stage > PERIOD_STAGE:
			if not edit_alarm_mode:
				add_note("You set the alarm clock's time to %s." % get_time_string())
			else:
				add_note("You set the alarm clock's alarm time to %s." % get_alarm_time_string())
			emit_signal("attempted_waiting", 1)
			end_event()

