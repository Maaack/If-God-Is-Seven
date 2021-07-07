extends Control


export(Resource) var starting_event : Resource

onready var title_label = $EventPanel/MarginContainer/Control/VBoxContainer/TitleLabel
onready var body_label = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyLabel
onready var body_texture_node = $EventPanel/MarginContainer/Control/VBoxContainer/HBoxContainer/BodyTextureRect

func set_event(event_data : EventData):
	title_label.text = event_data.title
	body_label.text = event_data.body
	body_texture_node.texture = event_data.background

func _ready():
	set_event(starting_event)

func _on_ContinueButton_pressed():
	queue_free()
