extends InteractableData


class_name BedInteractableData

enum made_states{TERRIBLE, BAD, POOR, FAIR, GOOD, PERFECT}

export(made_states) var made_state : int = made_states.PERFECT

func make_bed(effort : int = 1):
	made_state += effort
	if made_state >= made_states.PERFECT:
		made_state = made_states.PERFECT
