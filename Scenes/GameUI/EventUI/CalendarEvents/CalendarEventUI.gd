extends EventUI


class_name CalendarEventUI

var calendar : CalendarInteractableData setget set_calendar

func set_calendar(value : CalendarInteractableData):
	if calendar != null:
		print("Calendar already set for event")
		return
	calendar = value
