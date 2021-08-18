extends Resource


class_name ConditionData

export(String) var adjective : String
export(int, 0, 8) var intensity : int = 1
export(Array, InteractionConstants.interaction_types) var interactions_array : Array = [
	InteractionConstants.interaction_types.LOOK,
	InteractionConstants.interaction_types.LISTEN,
	InteractionConstants.interaction_types.SMELL,
	InteractionConstants.interaction_types.FEEL,
]
export(Array, String) var intensity_adverbs : Array = [
	"",
	"barely",
	"slightly",
	"moderately",
	"very",
	"extremely"
	]


func can_interact(interaction_type : int):
	return interaction_type in interactions_array

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

static func match_adjective_in_conditions(match_adjective : String, in_conditions : Array):
	for condition in in_conditions:
		if condition.adjective == match_adjective:
			return condition
	return null

