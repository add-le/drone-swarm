tool
extends EditorScript

var city = preload("res://liberty_city.tscn").instance();
var root = city.get_node(".")

func _run():
	root = get_scene()
	
	for i in root.get_children():
		var mesh: MeshInstance = i
		mesh.create_convex_collision()
