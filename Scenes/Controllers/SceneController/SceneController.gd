extends Control


export(PackedScene) var current_scene : PackedScene setget set_scene
var new_scene_container
var current_scene_container
var scene_container_scene = preload("res://Scenes/Controllers/SceneController/SceneContainer.tscn")

func set_scene(value : PackedScene):
	current_scene = value
	if current_scene == null:
		return
	new_scene_container = scene_container_scene.instance()
	new_scene_container.scene = current_scene
	add_child(new_scene_container)
	new_scene_container.connect("animation_finished", self, "_on_NewSceneContainer_animation_finished")
	new_scene_container.connect("scene_ready", self, "_on_SceneInstance_ready")
	if is_instance_valid(current_scene_container):
		new_scene_container.fade_in()
	else:
		new_scene_container.fade_in_fast()

func _on_NewSceneContainer_animation_finished():
	if is_instance_valid(current_scene_container):
		current_scene_container.queue_free()
	current_scene_container = new_scene_container

func _on_SceneInstance_ready(scene_instance : Node):
	scene_instance.connect("scene_changed", self, "_on_SceneInstance_scene_changed")

func _on_SceneInstance_scene_changed(scene : PackedScene):
	set_scene(scene)
