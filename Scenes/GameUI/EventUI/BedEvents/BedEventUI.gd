extends EventUI


class_name BedEventUI

const MADE_CONDITION = preload("res://Scenes/Data/Conditions/Bed/Made.tres")
const MESSY_CONDITION = preload("res://Scenes/Data/Conditions/Bed/Messy.tres")
const DAMP_CONDITION = preload("res://Scenes/Data/Conditions/Bed/Damp.tres")
const STINKY_CONDITION = preload("res://Scenes/Data/Conditions/Bed/Stinky.tres")

export(int) var max_made_intensity : int = 4
export(int) var min_messy_intensity : int = 1

func set_source_interactable(value : InteractableData):
	if not value is BedInteractableData:
		print("Was not BedInteractableData")
		return
	source_interactable = value

func _get_made_state_flavor_text():
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

func _ready():
	body_label.text = get_body_text() % [get_interaction_verb(), get_source_conditions_string(), _get_made_state_flavor_text()]

func _clean_bed() -> bool:
	var messy_condition = source_interactable.get_condition_by_adjective(MESSY_CONDITION.adjective)
	if messy_condition == null:
		messy_condition = MESSY_CONDITION.duplicate()
	if messy_condition.intensity <= min_messy_intensity:
		return false
	messy_condition.intensity -= 1
	source_interactable.set_condition(messy_condition)
	return true

func _make_bed() -> bool:
	var made_condition = source_interactable.get_condition_by_adjective(MADE_CONDITION.adjective)
	if made_condition == null:
		made_condition = MADE_CONDITION.duplicate()
	if made_condition.intensity >= max_made_intensity:
		return false
	made_condition.intensity += 1
	source_interactable.set_condition(made_condition)
	return true
	
func _on_MakeButton_pressed():
	if _clean_bed():
		emit_signal("added_historical_note", "You clean some of the mess from the bed.")
	if _make_bed():
		emit_signal("added_historical_note", "You made the bed for a bit.")
	else:
		emit_signal("added_historical_note", "You failed to make the bed look better.")
	emit_signal("attempted_waiting", 1)
	queue_free()

func _on_SleepButton_pressed():
	emit_signal("added_historical_note", "You slept in the bed for a full 24 hours!")
	emit_signal("attempted_waiting", 1440)
	queue_free()
