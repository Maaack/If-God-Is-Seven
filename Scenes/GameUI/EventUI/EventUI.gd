extends Control


class_name EventUI

onready var title_label = $EventPanel/MarginContainer/Control/VBoxContainer/TitleLabel
onready var body_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyLabel
onready var body_texture_node = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyTextureRect
onready var continue_button = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer2/ContinueButton

var init_body_text : String
var source_interactable : InteractableData setget set_source_interactable

func set_source_interactable(value : InteractableData):
	source_interactable = value

func get_title_text():
	return title_label.text

func get_body_text():
	return body_label.text

func get_body_texture():
	return body_texture_node.texture

func hide_continue_button():
	continue_button.hide()

func show_continue_button():
	continue_button.show()

func _on_ContinueButton_pressed():
	queue_free()

func _ready():
	init_body_text = body_label.text
