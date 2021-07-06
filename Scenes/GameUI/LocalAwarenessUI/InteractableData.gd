extends Resource


class_name InteractableData

enum interaction_types{LOOK, LISTEN, SMELL, SPEAK, USE, GRAB, TRAVEL}


export(String) var title : String
export(Array, interaction_types) var interaction_list : Array
