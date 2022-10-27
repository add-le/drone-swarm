extends Node

var astar: AStar = AStar.new()
onready var navigation: Navigation = $Navigation

var start = Vector3(0, 1, -2)
var stop = Vector3(0, 1, 2)

var path

func _ready():
	
	astar.add_point(0, start)
	astar.add_point(1, stop)
	astar.connect_points(0, 1, false)
	
	if astar.are_points_connected(0, 1, false):
		path = astar.get_point_path(0, 1)
		print(path)
	
	path = navigation.get_simple_path(start, stop)
	print(path)
