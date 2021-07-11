extends AlarmClockEventUI


onready var hour_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/HourLabel
onready var minute_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/MinuteLabel
onready var period_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/PeriodLabel
onready var separator_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/SeparatorLabel
onready var flash_timer = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/FlashTimer
onready var alarm_checkbox = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/AlarmCheckBox

enum {INIT_STAGE, HOUR_STAGE, MINUTE_STAGE, PERIOD_STAGE}

var current_use_stage : int = INIT_STAGE
var edit_alarm_mode : bool = false

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

func _ready():
	_update_time_labels()
	alarm_checkbox.pressed = source_interactable.alarm_ringing

func _reset_flashing():
	hour_label.show()
	minute_label.show()
	period_label.show()
	flash_timer.start()

func _on_FlashTimer_timeout():
	if source_interactable.alarm_ringing:
			hour_label.visible = !bool(hour_label.visible)
			minute_label.visible = hour_label.visible
			period_label.visible = hour_label.visible
			separator_label.visible = hour_label.visible
			alarm_checkbox.pressed = hour_label.visible
	else:
		match(current_use_stage):
			HOUR_STAGE:
				hour_label.visible = !bool(hour_label.visible)
			MINUTE_STAGE:
				minute_label.visible = !bool(minute_label.visible)
			PERIOD_STAGE:
				period_label.visible = !bool(period_label.visible)

func _on_ModButton_pressed():
	if source_interactable.alarm_ringing:
		source_interactable.alarm_ringing = false
		# TODO: Say something about the alarm stopping.
		queue_free()
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
		# TODO: Say something about the alarm stopping.
		queue_free()
	else:
		current_use_stage += 1
		continue_button.hide()
		_reset_flashing()
		if current_use_stage > PERIOD_STAGE:
			emit_signal("attempted_waiting", 1)
			queue_free()
