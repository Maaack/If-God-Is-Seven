extends Panel


signal pressed_location(location)
signal pressed_interactable(interaction, interactable)

onready var interactables_container = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/InteractablesContainer
onready var location_label = $VBoxContainer/DarkPanel/LocationLabel
onready var travel_ui = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/TravelUI
onready var interaction_label = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/MarginContainer/InteractactionLabel

var interactable_button_scene = preload("res://Scenes/GameUI/InteractableUI/InteractableButton.tscn")
var current_map : PackedScene setget set_current_map
var current_location : LocationData setget set_current_location
export(InteractableData.interaction_types) var current_interaction : int = 0

func _on_InteractionButton_pressed(interactable : InteractableData):
	emit_signal("pressed_interactable", current_interaction, interactable)

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
		interactable_button_instance.connect("pressed", self, "_on_InteractionButton_pressed", [interactable])

func set_current_map(value : PackedScene):
	current_map = value
	travel_ui.current_map = current_map

func set_current_location(value : LocationData):
	current_location = value
	travel_ui.current_location = current_location
	if current_location is LocationData:
		location_label.text = "%s" % [current_location.title]
	else:
		location_label.text = "???"
	update_interactables()

func _on_InteractionsPanel_changed_interaction(interaction):
	current_interaction = interaction
	update_interactables()

func _ready():
	set_current_location(travel_ui.current_location)

func _on_TravelUI_pressed_location(location):
	emit_signal("pressed_location", location)
