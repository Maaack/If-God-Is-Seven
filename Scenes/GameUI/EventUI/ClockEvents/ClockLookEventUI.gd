extends ClockEventUI


func get_look_time():
	return "%s:%s %s" % [get_hour_string(), get_minute_string(), get_period_string()]

func _ready():
	body_label.text = get_body_text() % get_look_time()
