extends Panel


signal pressed_location(location)
signal pressed_interactable(interaction, interactable)

onready var interactables_container = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/InteractablesContainer
onready var location_label = $VBoxContainer/DarkPanel/LocationLabel
onready var travel_ui = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/TravelUI
onready var interaction_label = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/ActionsContainer/MarginContainer/InteractactionLabel

var current_map : PackedScene setget set_current_map
var current_location : LocationData setget set_current_location
export(InteractionConstants.interaction_types) var current_interaction : int = 0

func _on_InteractionButton_pressed(interactable : InteractableData):
	emit_signal("pressed_interactable", current_interaction, interactable)

func _get_current_interactables():
	var current_interactables : Array = []
	if not current_location is LocationData:
		return current_interactables
	for interactable in current_location.interactables:
		if not interactable.can_interact(current_interaction):
			continue
		current_interactables.append(interactable)
	return current_interactables

func update_interactables():
	var current_interactables : Array = _get_current_interactables()
	for child in interactables_container.get_children():
		child.hide()
	travel_ui.visible = bool(current_interaction == InteractionConstants.interaction_types.TRAVEL)
	for i in range(current_interactables.size()):
		var interactable = current_interactables[i]
		var child = interactables_container.get_child(i)
		if child.is_connected("pressed", self, "_on_InteractionButton_pressed"):
			child.disconnect("pressed", self, "_on_InteractionButton_pressed")
		child.text = interactable.title
		child.connect("pressed", self, "_on_InteractionButton_pressed", [interactable])
		child.show()

func refresh():
	update_interactables()

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
	refresh()

func _on_InteractionsPanel_changed_interaction(interaction):
	current_interaction = interaction
	refresh()

func _ready():
	set_current_location(travel_ui.current_location)

func _on_TravelUI_pressed_location(location):
	emit_signal("pressed_location", location)
