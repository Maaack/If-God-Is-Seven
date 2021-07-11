extends InteractableData


class_name ClockInteractableData


const MINUTES_IN_HOUR : int = 60
const HOURS_IN_DAY : int = 24
const HOURS_IN_PERIOD : int = 12
const PERIODS_IN_DAY : int = 2

enum day_periods {AM, PM}

export(int) var current_hour : int = 8
export(int) var current_minute : int = 59
export(day_periods) var current_period : int = day_periods.AM
export(int) var current_day : int = 20

func add_minutes(minutes : int):
	var total_minute : int = current_minute + minutes
	var hours_added : int = total_minute / MINUTES_IN_HOUR
	current_minute = total_minute % MINUTES_IN_HOUR
	return hours_added

func add_hours(hours : int):
	var total_hour : int = current_hour + hours
	var periods_added : int = total_hour / HOURS_IN_PERIOD
	current_hour = total_hour % HOURS_IN_PERIOD
	return periods_added

func add_periods(periods : int):
	var total_period : int = current_period + periods
	var days_added : int = total_period / PERIODS_IN_DAY
	current_period = total_period % PERIODS_IN_DAY
	return days_added

func add_time(minutes : int):
	.add_time(minutes)
	var hours : int = add_minutes(minutes)
	var periods : int = add_hours(hours)
	var days : int= add_periods(periods)
	current_day += days
