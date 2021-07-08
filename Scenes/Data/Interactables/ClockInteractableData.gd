extends InteractableData


class_name ClockInteractableData


const MINUTES_IN_HOUR : int = 60
const HOURS_IN_DAY : int = 24
const HOURS_IN_PERIOD : int = 12
const PERIODS_IN_DAY : int = 2

enum day_periods {AM, PM}

export(int) var current_minute : int = 0
export(int) var current_hour : int = 9
export(day_periods) var current_period : int = day_periods.AM
export(int) var current_day : int = 20

func add_time(minutes : int):
	.add_time(minutes)
	var total_minute : int = current_minute + minutes
	var total_hour : int = current_hour + (total_minute / MINUTES_IN_HOUR)
	current_minute = total_minute % MINUTES_IN_HOUR
	var total_period = total_hour / HOURS_IN_PERIOD
	current_hour = total_hour % HOURS_IN_PERIOD
	current_day += total_period / PERIODS_IN_DAY
	current_period = total_period % PERIODS_IN_DAY

func get_look_time():
	var display_hour = current_hour
	if display_hour == 0:
		display_hour = 12
	var display_period = "AM"
	if current_period == day_periods.PM:
		display_period = "PM"
	return "%02d:%02d %s" % [display_hour, current_minute, display_period]

func get_look_event():
	var new_look_event = look_event.duplicate()
	new_look_event.body = new_look_event.body % get_look_time()
	return new_look_event
