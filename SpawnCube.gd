extends Node

var camera
var cube = preload("res://Cube.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = get_node("camera")

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var instance = cube.instance()
		instance.translation = camera.project_position(event.position, 10)
		add_child(instance)
