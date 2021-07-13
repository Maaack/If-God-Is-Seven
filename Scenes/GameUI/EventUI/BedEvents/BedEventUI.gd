extends EventUI


class_name BedEventUI

func set_source_interactable(value : InteractableData):
	if not value is BedInteractableData:
		print("Was not BedInteractableData")
		return
	source_interactable = value

func get_made_state_text():
	match(source_interactable.made_state):
		BedInteractableData.made_states.TERRIBLE:
			return "terrible"
		BedInteractableData.made_states.BAD:
			return "bad"
		BedInteractableData.made_states.POOR:
			return "poor"
		BedInteractableData.made_states.FAIR:
			return "fair"
		BedInteractableData.made_states.GOOD:
			return "good"
		BedInteractableData.made_states.PERFECT:
			return "perfect"
