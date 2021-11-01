extends BaseEventUI


class_name ModalEvent

onready var header_container = $CenterContainer/EventPanel/MarginContainer/VBoxContainer/HeaderContainer
onready var body_container = $CenterContainer/EventPanel/MarginContainer/VBoxContainer/BodyContainer
onready var footer_container = $CenterContainer/EventPanel/MarginContainer/VBoxContainer/FooterContainer
onready var continue_button = $CenterContainer/EventPanel/MarginContainer/VBoxContainer/FooterContainer/ContinueButton


func hide_continue_button():
	continue_button.hide()

func show_continue_button():
	continue_button.show()

func _on_ContinueButton_pressed():
	end_event()
