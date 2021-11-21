extends BaseEventUI

func start_event():
	.start_event()
	$HBoxContainer/LeftPortraitContainer/LeftPortrait.texture = interactable_data.portrait
	$HBoxContainer/RightPortraitContainer/RightPortrait.texture = interactable_data.portrait
	match interaction_type:
		InteractionConstants.interaction_types.SPEAK:
			if interactable_data.dialogue != "":
				for note in interactable_data.dialogue.split("\n"):
					add_note(note)
		InteractionConstants.interaction_types.LOOK:
			if interactable_data.visual_description != "":
				for note in interactable_data.visual_description.split("\n"):
					add_note(note)

func on_subtitle_finish_displaying():
	end_event()
