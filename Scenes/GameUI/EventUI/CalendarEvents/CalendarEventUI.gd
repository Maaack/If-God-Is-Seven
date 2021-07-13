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
