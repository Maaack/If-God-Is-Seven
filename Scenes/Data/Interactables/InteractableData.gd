extends Resource


class_name InteractableData

enum interaction_types{LOOK, LISTEN, SMELL, SPEAK, USE, GRAB, TRAVEL}


export(String) var title : String
export(Array, interaction_types) var interaction_list : Array
export(int) var age_in_minutes : int = 0

func add_time(minutes : int):
	age_in_minutes += minutes

func get_look_event():
	pass
