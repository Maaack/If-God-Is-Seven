tool
extends ViewportContainer


onready var scene_container = $Viewport

export var current_scene : PackedScene setget set_scene
var current_scene_instance

func set_scene(value : PackedScene):
	if is_instance_valid(current_scene_instance):
		current_scene_instance.queue_free()
	current_scene = value
	current_scene_instance = current_scene.instance()
	if is_instance_valid(scene_container):
		scene_container.add_child(current_scene_instance)

func _ready():
	set_scene(current_scene)
