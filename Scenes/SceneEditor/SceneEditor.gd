tool
extends Control


export(Resource) var location : Resource setget set_location

var button_scene = preload("res://Scenes/SceneEditor/SceneInteractableButton.tscn")

func _update_interactable_by_button(interactable : InteractableData, button : Button):
	interactable.scene_position = button.get_rect().position

func set_location(value : LocationData):
	var button_container_node = $ButtonContainer
	location = value
	if button_container_node != null:
		for child in button_container_node.get_children():
			child.queue_free()
	if location == null:
		return
	if $TextureRect != null:
		$TextureRect.texture = location.background
	if button_container_node != null:
		for interactable in location.interactables:
			if interactable is InteractableData:
				var button_instance = button_scene.instance()
				button_container_node.add_child(button_instance)
				button_instance.set_owner(get_tree().edited_scene_root)
				button_instance.text = interactable.title
				button_instance.set_position(interactable.scene_position)
				button_instance.connect("item_rect_changed", self, "_update_interactable_by_button", [interactable, button_instance])

