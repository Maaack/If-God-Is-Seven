extends ClockInteractableData


class_name AlarmClockInteractableData

export(int) var alarm_hour : int = 9
export(int) var alarm_minute : int = 0
export(day_periods) var alarm_period : int = day_periods.AM
export(bool) var alarm_ringing : bool = false setget set_alarm_ringing

var snooze_hour : int = 0
var snooze_minute : int = 0
var snooze_period : int = 0
var alarm_snoozing : bool = false setget set_alarm_snoozing

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

func add_snooze_minutes(minutes : int):
	var total_minute : int = snooze_minute + minutes
	var hours_added : int = total_minute / MINUTES_IN_HOUR
	snooze_minute = total_minute % MINUTES_IN_HOUR
	return hours_added

func add_snooze_hours(hours : int):
	var total_hour : int = snooze_hour + hours
	var periods_added : int = total_hour / HOURS_IN_PERIOD
	snooze_hour = total_hour % HOURS_IN_PERIOD
	return periods_added

func add_snooze_periods(periods : int):
	var total_period : int = snooze_period + periods
	var days_added : int = total_period / PERIODS_IN_DAY
	snooze_period = total_period % PERIODS_IN_DAY
	return days_added

func set_alarm_ringing(value : bool):
	alarm_ringing = value
	if alarm_ringing:
		add_interaction_type(InteractionConstants.interaction_types.LISTEN)
	else:
		alarm_snoozing = false
		remove_interaction_type(InteractionConstants.interaction_types.LISTEN)

func add_snooze_time(snooze_minutes : int = 5):
	var hours : int = add_snooze_minutes(snooze_minutes)
	var periods : int = add_snooze_hours(hours)
	add_snooze_periods(periods)

func set_alarm_snoozing(value : bool):
	if value == alarm_snoozing:
		return
	alarm_snoozing = value
	if alarm_snoozing:
		snooze_minute = current_minute
		snooze_hour = current_hour
		snooze_period = current_period
		add_snooze_time(5)

func is_snooze_alarm_now():
	if not alarm_snoozing:
		return false
	return current_hour == snooze_hour and current_minute == snooze_minute and current_period == snooze_period

func is_alarm_now():
	var alarm_now : bool = is_snooze_alarm_now()
	if not alarm_now:
		alarm_now = current_hour == alarm_hour and current_minute == alarm_minute and current_period == alarm_period
	return alarm_now

func add_time(minutes : int):
	.add_time(minutes)
	if is_alarm_now():
		set_alarm_ringing(true)
