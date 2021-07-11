extends ClockEventUI


onready var time_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyLabel/TimeLabel

func get_look_time():
	return "%s:%s %s" % [get_hour_string(), get_minute_string(), get_period_string()]

func _ready():
	time_label.text = get_look_time()
