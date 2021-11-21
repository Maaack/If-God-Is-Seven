extends Sprite


export(Texture) var arrow_pointer : Texture
export(Texture) var feel_pointer : Texture
export(Texture) var listen_pointer : Texture
export(Texture) var look_pointer : Texture
export(Texture) var smell_pointer : Texture
export(Texture) var grab_pointer : Texture
export(Texture) var speak_pointer : Texture
export(Texture) var travel_pointer : Texture
export(Texture) var wait_pointer : Texture
export(Vector2) var arrow_offset : Vector2

var active : bool = true setget set_active
var interaction_type : int = InteractionConstants.interaction_types.POINT setget set_interaction_type

func set_interaction_type(value : int):
	interaction_type = value
	set_offset(Vector2.ZERO)
	match(value):
		InteractionConstants.interaction_types.FEEL:
			set_texture(feel_pointer)
		InteractionConstants.interaction_types.LISTEN:
			set_texture(listen_pointer)
		InteractionConstants.interaction_types.LOOK:
			set_texture(look_pointer)
		InteractionConstants.interaction_types.SMELL:
			set_texture(smell_pointer)
		InteractionConstants.interaction_types.GRAB:
			set_texture(grab_pointer)
		InteractionConstants.interaction_types.SPEAK:
			set_texture(speak_pointer)
		InteractionConstants.interaction_types.TRAVEL:
			set_texture(travel_pointer)
		InteractionConstants.interaction_types.POINT:
			set_texture(arrow_pointer)
			set_offset(arrow_offset)
		InteractionConstants.interaction_types.WAIT:
			set_texture(wait_pointer)

func _ready():
	set_active(active)
	var mouse_window_position = get_viewport().get_mouse_position()
	var window_ratio = get_viewport().size / get_tree().root.size 
	position = mouse_window_position * window_ratio

func _input(event):
	if event is InputEventMouseMotion:
		position = event.position

func _exit_tree():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func set_active(value : bool):
	active = value
	if active:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
