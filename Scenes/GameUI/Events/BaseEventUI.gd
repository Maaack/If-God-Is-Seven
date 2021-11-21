extends Control


class_name BaseEventUI

signal added_time(minutes)
signal added_note(note)
signal altered_condition(adjective, delta)
signal started_event
signal advanced_event
signal ended_event

export(InteractionConstants.interaction_types) var interaction_type : int

var interactable_data : InteractableData

func add_time(minutes : int):
	if minutes == 0:
		return
	emit_signal("added_time", minutes)

func add_note(text : String):
	if text == "":
		return
	emit_signal("added_note", text)

func start_event():
	emit_signal("started_event")

func advance_event():
	emit_signal("advanced_event")

func end_event():
	emit_signal("ended_event")

func _get_interactable_condition_or_new(condition : ConditionData):
	var match_condition : ConditionData = interactable_data.get_condition_by_adjective(condition.adjective)
	if match_condition == null:
		return condition.duplicate()
	return match_condition

func _alter_condition(condition : ConditionData, intensity_delta : int, min_limit : int = -1,  max_limit : int = -1):
	if max_limit < 0:
		max_limit = condition.intensity_adverbs.size() - 1
	if min_limit < 0:
		min_limit = 0
	var match_condition =_get_interactable_condition_or_new(condition)
	if (intensity_delta < 0 and match_condition.intensity <= min_limit) or \
		(intensity_delta > 0 and match_condition.intensity >= max_limit):
		return false
	match_condition.intensity += intensity_delta
	interactable_data.set_condition(match_condition)
	return true

func on_subtitle_finish_displaying():
	pass

func get_interaction_verb() -> String:
	match(interaction_type):
		InteractionConstants.interaction_types.LOOK:
			return 'looks'
		InteractionConstants.interaction_types.LISTEN:
			return 'sounds'
		InteractionConstants.interaction_types.SMELL:
			return 'smells'
		InteractionConstants.interaction_types.FEEL:
			return 'feels'
		InteractionConstants.interaction_types.USE:
			return 'feels'
		_:
			return ''
