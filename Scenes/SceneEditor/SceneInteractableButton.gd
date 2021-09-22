extends Button


var light_gray_style_box = preload("res://Styles/LightGrayButtonStyleBox.tres")
var normal_style_box = preload("res://Styles/NormalButtonStyleBox.tres")
var gray : bool = false setget set_gray

func set_gray(value : bool):
	gray = value
	if gray:
		set("custom_styles/normal", light_gray_style_box)
	else:
		set("custom_styles/normal", normal_style_box)
