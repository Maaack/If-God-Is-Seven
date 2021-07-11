extends CalendarEventUI


func get_look_date():
	return "June %d, 1986" % [get_current_day()]

func _ready():
	body_label.text = get_body_text() % get_look_date()
