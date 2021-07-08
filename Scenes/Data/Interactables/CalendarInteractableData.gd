extends InteractableData


class_name CalendarInteractableData

const MINUTES_IN_DAY : int = 1440

export(int) var current_day : int = 20

func get_look_date():
	return "June %d, 1986" % [(current_day + (age_in_minutes / MINUTES_IN_DAY))]

func get_look_event():
	var new_look_event = look_event.duplicate()
	new_look_event.body = new_look_event.body % get_look_date()
	return new_look_event

