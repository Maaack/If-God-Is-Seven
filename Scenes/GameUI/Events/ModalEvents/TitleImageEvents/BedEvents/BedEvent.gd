extends ModalEvent


const MADE_CONDITION = preload("res://Scenes/Data/Conditions/Bed/Made.tres")
const MESSY_CONDITION = preload("res://Scenes/Data/Conditions/Bed/Messy.tres")
const DAMP_SWEAT_CONDITION = preload("res://Scenes/Data/Conditions/Bed/DampWithSweat.tres")
const STINKY_SWEAT_CONDITION = preload("res://Scenes/Data/Conditions/Bed/StinkyWithSweat.tres")

export(int) var made_intensity_max : int = 4

func _concat_three_or_more(conditions : Array) -> String:
	var all_conditions : String = ""
	for i in conditions.size():
		var condition : ConditionData = conditions[i]
		var condition_string : String = str(condition)
		if i == conditions.size() - 1:
			all_conditions += "and %s" % [condition_string]
		else:
			all_conditions += "%s, " % [condition_string]
	return all_conditions

func _get_interactable_condition_string() -> String:
	var filtered_conditions : Array = interactable_data.get_filtered_conditions(interaction_type)
	match(filtered_conditions.size()):
		0:
			return ""
		1:
			return "%s" % [str(filtered_conditions[0])]
		2:
			return "%s and %s" % [str(filtered_conditions[0]), str(filtered_conditions[1])]
		_:
			return _concat_three_or_more(filtered_conditions)

func _get_stinky_flavor_text():
	var condition : ConditionData = _get_interactable_condition_or_new(STINKY_SWEAT_CONDITION)
	if condition.is_interactable(interaction_type):
		match(condition.intensity):
			1, 2:
				return "It's really only noticeable if you're up in them."
			3:
				return "That could still be embarrasing if someone caught a whiff."
			4:
				return "That stink is really bad."
			5:
				return "The smell is gag inducing."
	return ""

func _get_damp_flavor_text():
	var condition : ConditionData = _get_interactable_condition_or_new(DAMP_SWEAT_CONDITION)
	if condition.is_interactable(interaction_type):
		match(condition.intensity):
			1, 2:
				return "Hopefully the sheets are able to dry before you go to sleep again."
			3, 4, 5:
				return "Sheets this wet beg the question whether it's just sweat."
	return ""

func _get_made_state_flavor_text() -> String:
	var condition : ConditionData = _get_interactable_condition_or_new(MADE_CONDITION)
	if condition.is_interactable(interaction_type):
		match(condition.intensity):
			0:
				return "It looks like you didn't make your bed."
			1:
				return "It still looks like you didn't make your bed..."
			2:
				return "It looks like someone lazily made the bed. Like \"good enough.\""
			3:
				return "It looks like time was taken to carefully make this bed."
			4:
				return "This is the best you can make a bed look."
			5:
				return "You literally cannot make beds look this made."
	return ""

func _get_flavor_text():
	var all_text : String = ""
	var flavor_texts : Array = [_get_stinky_flavor_text(), _get_damp_flavor_text(), _get_made_state_flavor_text()]
	for flavor_text in flavor_texts:
		if flavor_text == "":
			continue
		all_text += flavor_text + " "
	return all_text.trim_suffix(" ")

func start_event():
	.start_event()
	add_note("The bed %s %s." % [get_interaction_verb(), _get_interactable_condition_string()])
	add_note(_get_flavor_text())

func _clean_bed() -> bool:
	return _alter_condition(MESSY_CONDITION, -1)

func _make_bed() -> bool:
	return _alter_condition(MADE_CONDITION, 1, 0, made_intensity_max)

func _on_MakeButton_pressed():
	if _clean_bed():
		add_note("You clean some of the mess from the bed.")
	if _make_bed():
		add_note("You made the bed for a bit.")
	else:
		add_note("You failed to make the bed look better.")
	add_time(1)
	queue_free()

func _on_SleepButton_pressed():
	add_note("You slept in the bed for a full 24 hours!")
	add_time(1440)
	queue_free()
