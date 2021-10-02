extends Control


signal animation_finished
signal scene_ready(scene_instance)

onready var container = $Viewport
var scene : PackedScene

func _ready():
	var scene_instance = scene.instance()
	container.add_child(scene_instance)
	emit_signal("scene_ready", scene_instance)

func fade_in():
	$AnimationPlayer.play("FadeIn")

func fade_in_fast():
	$AnimationPlayer.play("FadeInFast")

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("animation_finished")
