extends Control


class_name BaseEventUI

signal added_time(minutes)
signal added_note(note)
signal altered_condition(adjective, delta)
signal started_event
signal advanced_event
signal ended_event

export(Resource) var interactable_data : Resource
export(InteractionConstants.interaction_types) var interaction_type : int

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

func _alter_condition(condition : ConditionData, intensity_delta : int, min_limit : int = -1,  max_limit : int = -1):
	if max_limit < 0:
		max_limit = condition.intensity_adverbs.size() - 1
	if min_limit < 0:
		min_limit = 0
		emit_signal("altered_condition", condition.adjective, intensity_delta)

func on_subtitle_finish_displaying():
	pass
