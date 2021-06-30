extends Panel

onready var interactables_container = $MarginContainer/HBoxContainer/InteractablesContainer

var interactable_button_scene = preload("res://Scenes/GameUI/LocalAwarenessUI/InteractableButton.tscn")
var current_location : LocationData setget set_current_location
var current_interaction : int = 0

func update_interactables():
	for child in interactables_container.get_children():
		child.queue_free()
	if not current_location is LocationData:
		return
	for interactable in current_location.interactables:
		if not current_interaction in interactable.interaction_list:
			continue
		var interactable_button_instance = interactable_button_scene.instance()
		interactables_container.add_child(interactable_button_instance)
		interactable_button_instance.text = interactable.title

func set_current_location(value : LocationData):
	current_location = value
	update_interactables()

func _on_LookButton_pressed():
	current_interaction = InteractableData.interaction_types.LOOK
	update_interactables()

func _on_ListenButton_pressed():
	current_interaction = InteractableData.interaction_types.LISTEN
	update_interactables()

func _on_SmellButton_pressed():
	current_interaction = InteractableData.interaction_types.SMELL
	update_interactables()

func _on_SpeakButton_pressed():
	current_interaction = InteractableData.interaction_types.SPEAK
	update_interactables()

func _on_UseButton_pressed():
	current_interaction = InteractableData.interaction_types.USE
	update_interactables()

func _on_GrabButton_pressed():
	current_interaction = InteractableData.interaction_types.GRAB
	update_interactables()
