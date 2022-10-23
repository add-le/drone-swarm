extends KinematicBody

onready var nav = $"../Navigation" as Navigation
onready var objectif = $"../Objectif" as StaticBody

var path = []

func _ready():
	
	path = nav.get_simple_path(global_transform.origin, objectif.global_transform.origin)
	print(path)
