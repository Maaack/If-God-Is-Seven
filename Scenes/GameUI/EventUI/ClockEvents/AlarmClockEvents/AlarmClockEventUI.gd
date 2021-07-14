extends ClockEventUI


class_name AlarmClockEventUI

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
