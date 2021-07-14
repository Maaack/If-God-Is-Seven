extends Node

signal added_time(minutes)

const MINUTES_IN_HOUR : int = 60
const HOURS_IN_DAY : int = 24

export(Array, Resource) var world_maps : Array
export(Resource) var current_location : Resource

var current_map_index : int = 0
var current_time : int = 0
var all_locations : Array = []

func get_current_location():
	return current_location

func get_current_map():
	return world_maps[current_map_index]

func travel_to(location : LocationData):
	var travel_time : int = get_travel_time_to(location)
	add_time(travel_time)
	current_location = location

func get_travel_time_to(_location : LocationData):
	var current_map_instance = get_current_map().instance()
	return current_map_instance.travel_time_in_minutes

func get_map_instances():
	var all_map_instances : Array = []
	for map_scene in world_maps:
		if map_scene is PackedScene:
			var interactable_map : InteractableMap = map_scene.instance()
			all_map_instances.append(interactable_map)
	return all_map_instances

func get_locations():
	return all_locations

func reset_all_locations():
	all_locations.clear()
	var maps : Array = get_map_instances()
	for interactable_map in maps:
		if interactable_map is InteractableMap:
			all_locations.append_array(interactable_map.get_locations())

func get_interactables():
	var all_interactables : Array = []
	for location in get_locations():
		if location is LocationData:
			all_interactables.append_array(location.interactables)
	return all_interactables

func add_time_to_interactables(minutes : int):
	for interactable in get_interactables():
		if interactable is InteractableData:
			interactable.add_time(minutes)

func add_time(minutes : int):
	current_time += minutes
	add_time_to_interactables(minutes)
	emit_signal("added_time", minutes)

func get_current_minute():
	return current_time % MINUTES_IN_HOUR

func get_current_hour():
	var current_hours = current_time / MINUTES_IN_HOUR
	return current_hours % HOURS_IN_DAY

func get_current_day():
	return current_time / (MINUTES_IN_HOUR * HOURS_IN_DAY)

func _ready():
	reset_all_locations()
