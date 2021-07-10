extends CalendarEventUI



func get_look_date():
	return "June %d, 1986" % [(calendar.current_day + (calendar.age_in_minutes / calendar.MINUTES_IN_DAY))]

func _ready():
	body_label.text = get_body_text() % get_look_date()
