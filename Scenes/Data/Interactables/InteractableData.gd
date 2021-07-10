extends Resource


class_name InteractableData

enum interaction_types{LOOK, LISTEN, SMELL, SPEAK, USE, GRAB, TRAVEL}


export(String) var title : String
export(Array, interaction_types) var interaction_list : Array
export(int) var age_in_minutes : int = 0
export(PackedScene) var look_event : PackedScene
export(PackedScene) var use_event : PackedScene

func add_time(minutes : int):
	age_in_minutes += minutes

func has_look_event():
	return look_event != null

func get_look_event():
	return look_event.instance()

func get_use_event():
	return use_event.instance()
