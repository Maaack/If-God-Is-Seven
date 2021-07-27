extends Resource


class_name ConditionData

enum intensity_adverbs{NONE, BARELY, SLIGHTLY, MODERATELY, VERY, EXTREMELY}

export(String) var adjective : String
export(intensity_adverbs) var intensity : int = 1
export(bool) var can_look : bool
export(bool) var can_listen : bool
export(bool) var can_smell : bool
export(bool) var can_feel : bool

func get_adverb() -> String:
	match(intensity):
		intensity_adverbs.BARELY:
			return "barely"
		intensity_adverbs.SLIGHTLY:
			return "slightly"
		intensity_adverbs.MODERATELY:
			return "moderately"
		intensity_adverbs.VERY:
			return "very"
		intensity_adverbs.EXTREMELY:
			return "extremely"
		intensity_adverbs.NONE, _:
			return ""

func get_adverb_with_space() -> String:
	var adverb : String = get_adverb()
	if adverb != "":
		adverb += " "
	return adverb

func _to_string():
	return "%s%s" % [get_adverb_with_space(), adjective]
