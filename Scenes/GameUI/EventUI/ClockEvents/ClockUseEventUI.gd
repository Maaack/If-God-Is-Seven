extends ClockEventUI


onready var hour_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/HourLabel
onready var minute_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/MinuteLabel
onready var period_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/PeriodLabel
onready var flash_timer = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyCenter/Panel/FlashTimer

enum {HOUR_STAGE, MINUTE_STAGE, PERIOD_STAGE}

var current_use_stage : int = HOUR_STAGE

func _ready():
	hour_label.text = get_hour_string()
	minute_label.text = get_minute_string()
	period_label.text = get_period_string()

func _reset_flashing():
	hour_label.show()
	minute_label.show()
	period_label.show()
	flash_timer.start()

func _on_FlashTimer_timeout():
	match(current_use_stage):
		HOUR_STAGE:
			hour_label.visible = !bool(hour_label.visible)
		MINUTE_STAGE:
			minute_label.visible = !bool(minute_label.visible)
		PERIOD_STAGE:
			period_label.visible = !bool(period_label.visible)

func _on_ModButton_pressed():
	match(current_use_stage):
		HOUR_STAGE:
			clock.add_hours(1)
			hour_label.text = get_hour_string()
		MINUTE_STAGE:
			clock.add_minutes(1)
			minute_label.text = get_minute_string()
		PERIOD_STAGE:
			clock.add_periods(1)
			period_label.text = get_period_string()
	_reset_flashing()

func _on_SetButton_pressed():
	current_use_stage += 1
	_reset_flashing()
	if current_use_stage > PERIOD_STAGE:
		queue_free()
