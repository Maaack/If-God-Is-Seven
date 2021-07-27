extends BedEventUI


func get_made_state_flavor_text():
	match(source_interactable.made_state):
		BedInteractableData.made_states.TERRIBLE:
			return "It doesn't look like a bed you want to sleep in."
		BedInteractableData.made_states.BAD:
			return "It looks like you didn't sleep well last night."
		BedInteractableData.made_states.POOR:
			return "It looks like you didn't make your bed, yet."
		BedInteractableData.made_states.FAIR:
			return "It looks like you lazily made your bed. Good enough."
		BedInteractableData.made_states.GOOD:
			return "It looks like you took the time to carefully make your bed."
		BedInteractableData.made_states.PERFECT:
			return "You can't make beds look this good."

func get_condition_text():
	var conditions_text : String = source_interactable.get_conditions_string(InteractableData.interaction_types.LOOK)
	if conditions_text.length() > 0:
		return "%s\nIt looks %s." % [get_made_state_flavor_text(), conditions_text]
	return "%s" % [get_made_state_flavor_text()]

func _ready():
	body_label.text = get_body_text() % [get_made_state_text(), get_condition_text()]
