extends ClockInteractableData


class_name AlarmClockInteractableData


export(int) var alarm_minute : int = 0
export(int) var alarm_hour : int = 9
export(day_periods) var alarm_period : int = day_periods.AM
export(bool) var alarm_ringing : bool = false setget set_alarm_ringing
export(PackedScene) var alarm_listen_event : PackedScene

func add_alarm_minutes(minutes : int):
	var total_minute : int = alarm_minute + minutes
	var hours_added : int = total_minute / MINUTES_IN_HOUR
	alarm_minute = total_minute % MINUTES_IN_HOUR
	return hours_added

func add_alarm_hours(hours : int):
	var total_hour : int = alarm_hour + hours
	var periods_added : int = total_hour / HOURS_IN_PERIOD
	alarm_hour = total_hour % HOURS_IN_PERIOD
	return periods_added

func add_alarm_periods(periods : int):
	var total_period : int = alarm_period + periods
	var days_added : int = total_period / PERIODS_IN_DAY
	alarm_period = total_period % PERIODS_IN_DAY
	return days_added

func set_alarm_ringing(value : bool):
	alarm_ringing = value
	if alarm_ringing:
		listen_event = alarm_listen_event
	else:
		listen_event = null

func add_time(minutes : int):
	.add_time(minutes)
	if current_hour == alarm_hour and current_minute == alarm_minute and current_period == alarm_period:
		set_alarm_ringing(true)
	else:
		set_alarm_ringing(false)
