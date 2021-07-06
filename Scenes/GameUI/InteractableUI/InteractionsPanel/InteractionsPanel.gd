extends Panel


signal changed_interaction(interaction)

func _on_LookButton_pressed():
	emit_signal("changed_interaction", InteractableData.interaction_types.LOOK)

func _on_ListenButton_pressed():
	emit_signal("changed_interaction", InteractableData.interaction_types.LISTEN)

func _on_SmellButton_pressed():
	emit_signal("changed_interaction", InteractableData.interaction_types.SMELL)

func _on_InteractButton_pressed():
	emit_signal("changed_interaction", InteractableData.interaction_types.USE)

func _on_GrabButton_pressed():
	emit_signal("changed_interaction", InteractableData.interaction_types.GRAB)

func _on_SpeakButton_pressed():
	emit_signal("changed_interaction", InteractableData.interaction_types.SPEAK)

func _on_ApparelButton_pressed():
	pass # Replace with function body.

func _on_InventoryButton_pressed():
	pass # Replace with function body.

func _on_TravelButton_pressed():
		emit_signal("changed_interaction", InteractableData.interaction_types.TRAVEL)
