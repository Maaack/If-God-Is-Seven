extends ModalEvent


func get_day_offset_by_age():
	return interactable_data.age_in_minutes / interactable_data.MINUTES_IN_DAY

func get_current_day():
	return interactable_data.current_day + get_day_offset_by_age()

func get_look_date():
	return "June %d, 1986" % [get_current_day()]

func _ready():
	add_note("The calendar reads %s" % get_look_date())
