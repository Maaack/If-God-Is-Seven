extends EventUI


class_name ClockEventUI

var clock : ClockInteractableData setget set_clock

func set_clock(value : ClockInteractableData):
	if clock != null:
		print("Clock already set for event")
		return
	clock = value

func get_period_string():
	if clock.current_period == ClockInteractableData.day_periods.PM:
		return "PM"
	else:
		return "AM"

func get_hour_string():
	var current_hour : int = clock.current_hour
	if current_hour == 0:
		current_hour = 12
	return "%02d" % current_hour

func get_minute_string():
	return "%02d" % clock.current_minute
