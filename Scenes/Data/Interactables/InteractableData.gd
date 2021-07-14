extends Resource


class_name InteractableData

enum interaction_types{LOOK, LISTEN, SMELL, SPEAK, USE, GRAB, TRAVEL}


export(String) var title : String
export(PackedScene) var look_event : PackedScene
export(PackedScene) var listen_event : PackedScene
export(PackedScene) var smell_event : PackedScene
export(PackedScene) var use_event : PackedScene

var age_in_minutes : int = 0

func add_time(minutes : int):
	age_in_minutes += minutes

func get_event_scene(interaction_type : int):
	match(interaction_type):
		interaction_types.LOOK:
			return look_event
		interaction_types.LISTEN:
			return listen_event
		interaction_types.SMELL:
			return smell_event
		interaction_types.USE:
			return use_event

func has_event_scene(interaction_type : int):
	var event_scene : PackedScene = get_event_scene(interaction_type)
	return event_scene != null

func get_event_ui(interaction_type : int):
	var event_scene : PackedScene = get_event_scene(interaction_type)
	if event_scene == null:
		return
	var event_ui = event_scene.instance()
	if event_ui == null:
		return
	event_ui.source_interactable = self
	return event_ui
