extends Node2D


var active : bool = true setget set_active

func _hide_all_icons():
	for child in get_children():
		child.hide()

func set_interaction_type(value : int):
	_hide_all_icons()
	match(value):
		InteractionConstants.interaction_types.FEEL:
			$Feel.show()
		InteractionConstants.interaction_types.LISTEN:
			$Listen.show()
		InteractionConstants.interaction_types.LOOK:
			$Look.show()
		InteractionConstants.interaction_types.SMELL:
			$Smell.show()
		InteractionConstants.interaction_types.GRAB:
			$Take.show()
		InteractionConstants.interaction_types.SPEAK:
			$Speak.show()
		InteractionConstants.interaction_types.TRAVEL:
			$Travel.show()
		InteractionConstants.interaction_types.POINT:
			$ArrowPointer.show()

func set_active(value : bool):
	active = value
	if active:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _update_position():
	position = get_local_mouse_position()

func _input(event):
	if event is InputEventMouseMotion:
		position = event.position

func _ready():
	set_active(active)
	_update_position()

func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
