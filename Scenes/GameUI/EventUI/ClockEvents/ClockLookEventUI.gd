extends ClockEventUI


func get_look_time():
	var display_hour = clock.current_hour
	if display_hour == 0:
		display_hour = 12
	var display_period = get_period_string()
	return "%02d:%02d %s" % [display_hour, clock.current_minute, display_period]

func _ready():
	body_label.text = get_body_text() % get_look_time()
