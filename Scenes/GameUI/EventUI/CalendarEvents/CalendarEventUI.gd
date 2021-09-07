extends EventUI


class_name CalendarEventUI

func set_source_interactable(value : InteractableData):
	if not value is CalendarInteractableData:
		print("Was not CalendarInteractableData")
		return
	source_interactable = value

func get_day_offset_by_age():
	return source_interactable.age_in_minutes / source_interactable.MINUTES_IN_DAY

func get_current_day():
	return source_interactable.current_day + get_day_offset_by_age()

func get_look_date():
	return "June %d, 1986" % [get_current_day()]

func _ready():
	body_label.text = get_body_text() % get_look_date()
	log_event_text("The calendar reads %s" % get_look_date())
