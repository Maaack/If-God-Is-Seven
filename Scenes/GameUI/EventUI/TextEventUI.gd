extends EventUI


onready var body_label = $PanelContainer/MarginContainer/BodyLabel

func get_body_text():
	return body_label.text

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == BUTTON_LEFT:
			end_event()

func _ready():
	log_event_text(get_body_text())
