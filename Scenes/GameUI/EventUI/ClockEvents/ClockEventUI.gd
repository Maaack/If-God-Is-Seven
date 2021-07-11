extends EventUI


class_name ClockEventUI

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
