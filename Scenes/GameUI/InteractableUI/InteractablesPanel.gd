extends Panel


signal changed_location(location)

onready var interactables_container = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/InteractablesContainer
onready var location_label = $VBoxContainer/DarkPanel/LocationLabel
onready var travel_ui = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/TravelUI

var interactable_button_scene = preload("res://Scenes/GameUI/LocalAwarenessUI/InteractableButton.tscn")
var current_location : LocationData setget set_current_location
var current_interaction : int = 0

func update_interactables():
	for child in interactables_container.get_children():
		child.queue_free()
		yield(interactables_container, "draw")
	travel_ui.visible = bool(current_interaction == InteractableData.interaction_types.TRAVEL)
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
	if current_location is LocationData:
		location_label.text = "%s" % [current_location.title]
	else:
		location_label.text = "???"
	update_interactables()

func _on_TravelUI_changed_location(location):
	set_current_location(location)
	emit_signal("changed_location", location)

func _on_InteractionsPanel_changed_interaction(interaction):
	current_interaction = interaction
	update_interactables()
