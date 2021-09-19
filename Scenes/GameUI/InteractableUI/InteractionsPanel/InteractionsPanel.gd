extends Panel


signal changed_interaction(interaction)

func update_interactions_available(interactions_array : Array):
	$MarginContainer/InteractionOptionsContainer/LookButton.disabled = not InteractionConstants.interaction_types.LOOK in interactions_array
	$MarginContainer/InteractionOptionsContainer/ListenButton.disabled = not InteractionConstants.interaction_types.LISTEN in interactions_array
	$MarginContainer/InteractionOptionsContainer/SmellButton.disabled = not InteractionConstants.interaction_types.SMELL in interactions_array
	$MarginContainer/InteractionOptionsContainer/FeelButton.disabled = not InteractionConstants.interaction_types.FEEL in interactions_array
	$MarginContainer/InteractionOptionsContainer/GrabButton.disabled = not InteractionConstants.interaction_types.GRAB in interactions_array
	$MarginContainer/InteractionOptionsContainer/SpeakButton.disabled = not InteractionConstants.interaction_types.SPEAK in interactions_array

func update_interaction_type_set(interaction_type : int):
	$MarginContainer/InteractionOptionsContainer/LookButton.pressed = InteractionConstants.interaction_types.LOOK == interaction_type
	$MarginContainer/InteractionOptionsContainer/ListenButton.pressed = InteractionConstants.interaction_types.LISTEN == interaction_type
	$MarginContainer/InteractionOptionsContainer/SmellButton.pressed = InteractionConstants.interaction_types.SMELL == interaction_type
	$MarginContainer/InteractionOptionsContainer/FeelButton.pressed = InteractionConstants.interaction_types.FEEL == interaction_type
	$MarginContainer/InteractionOptionsContainer/GrabButton.pressed = InteractionConstants.interaction_types.GRAB == interaction_type
	$MarginContainer/InteractionOptionsContainer/SpeakButton.pressed = InteractionConstants.interaction_types.SPEAK == interaction_type

func _on_LookButton_pressed():
	emit_signal("changed_interaction", InteractionConstants.interaction_types.LOOK)

func _on_ListenButton_pressed():
	emit_signal("changed_interaction", InteractionConstants.interaction_types.LISTEN)

func _on_SmellButton_pressed():
	emit_signal("changed_interaction", InteractionConstants.interaction_types.SMELL)

func _on_InteractButton_pressed():
	emit_signal("changed_interaction", InteractionConstants.interaction_types.USE)

func _on_GrabButton_pressed():
	emit_signal("changed_interaction", InteractionConstants.interaction_types.GRAB)

func _on_SpeakButton_pressed():
	emit_signal("changed_interaction", InteractionConstants.interaction_types.SPEAK)

func _on_ApparelButton_pressed():
	pass # Replace with function body.

func _on_InventoryButton_pressed():
	pass # Replace with function body.

func _on_TravelButton_pressed():
		emit_signal("changed_interaction", InteractionConstants.interaction_types.TRAVEL)

func _on_MapButton_pressed():
	pass # Replace with function body.


func _on_TouchButton_pressed():
	emit_signal("changed_interaction", InteractionConstants.interaction_types.FEEL)
