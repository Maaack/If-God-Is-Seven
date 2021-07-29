extends Resource


class_name ConditionData

export(String) var adjective : String
export(int, 0, 8) var intensity : int = 1
export(bool) var can_look : bool
export(bool) var can_listen : bool
export(bool) var can_smell : bool
export(bool) var can_feel : bool
export(Array, String) var intensity_adverbs : Array = [
	"",
	"barely",
	"slightly",
	"moderately",
	"very",
	"extremely"
	]

func is_interactable(interaction_type : int):
	match(interaction_type):
		InteractionConstants.interaction_types.LOOK:
			return can_look
		InteractionConstants.interaction_types.LISTEN:
			return can_listen
		InteractionConstants.interaction_types.SMELL:
			return can_smell
		InteractionConstants.interaction_types.USE:
			return can_feel

func get_adverb() -> String:
	if intensity < 0 or intensity >= intensity_adverbs.size():
		return ""
	return intensity_adverbs[intensity]

func get_adverb_with_space() -> String:
	var adverb : String = get_adverb()
	if adverb != "":
		adverb += " "
	return adverb

func _to_string():
	return "%s%s" % [get_adverb_with_space(), adjective]
