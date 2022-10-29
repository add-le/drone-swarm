extends Spatial

var droneObject = preload("res://Drone/untitled.tscn");
var drone:KinematicBody = null;
var drone2:KinematicBody = null;
var drone3:KinematicBody = null;
var objectifObject = preload("Objectif.tscn");
var objectif:RigidBody = null;
#var drones:KinematicBody[] = [];
var coordonnees = Vector3(0,30,0);
var coordonnees2 = Vector3(5,30,0);
var coordonnees3 = Vector3(10,30,0);
var objectifCoordonnees = coordonnees;
var vitesse_rotation:float = PI;

# Récupère les différentes nodes
onready var camera: Camera = $Camera
onready var navigation: Navigation = $Navigation

var path = []

# A* Algorithm
var astar: AStar = AStar.new()

var coo


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	if drone == null:
		drone = droneObject.instance();
		drone.translation = coordonnees;
		add_child(drone);
		
	if drone2 == null:
		drone2 = droneObject.instance();
		drone2.translation = coordonnees2;
		add_child(drone2);

	if drone3 == null:
		drone3 = droneObject.instance();
		drone3.translation = coordonnees3;
		add_child(drone3);
	
	if objectif == null:
#		genereObjectif();
		pass
	

func getAStarPath(target_position):
	astar.add_point(0, drone.global_transform.origin)
	astar.add_point(1, target_position)
	astar.connect_points(0, 1, false)
	
	if astar.are_points_connected(0, 1, false):
		path = astar.get_point_path(0, 1)
#		print(path)


func genereObjectif():
	var x = rand_range(-40,40);
	var z = rand_range(-40,40);
	objectifCoordonnees = Vector3(x,objectifCoordonnees.y,z);
	
#	var target: Position3D = Position3D.new()
#	objectif = target.instance()
	objectif = objectifObject.instance();
	objectif.translation = objectifCoordonnees;
	# Insertion objectif dans la scène principale
	add_child(objectif);


func _input(ev):
	# Place l'objectif à l'endroit du clic
	if ev is InputEventMouseButton and ev.button_index == BUTTON_LEFT and ev.is_pressed():
#		objectif.queue_free()
#		objectif = objectifObject.instance()
		coo = camera.project_position(ev.position, 10)
		coo.y = 30
		current_node = 0
#		print(path)
#		add_child(objectif)
	
	if ev is InputEventKey and ev.scancode == KEY_SPACE and ev.is_pressed():
		if objectif != null:
			objectif.queue_free();
#		genereObjectif();

	if ev is InputEventKey and ev.scancode == KEY_S and ev.is_pressed():
		objectif.translation.z = objectif.translation.z-5;
	if ev is InputEventKey and ev.scancode == KEY_Z and ev.is_pressed():
		objectif.translation.z = objectif.translation.z+5;
	if ev is InputEventKey and ev.scancode == KEY_Q and ev.is_pressed():
		objectif.translation.x = objectif.translation.x+5;
	if ev is InputEventKey and ev.scancode == KEY_D and ev.is_pressed():
		objectif.translation.x = objectif.translation.x-5;
	#print(objectif.translation);

var velocity: Vector3
var speed = 5
var current_node = 0
func _physics_process(delta):
	
	if coo != null:
	
		# Permet au drone de regarder dans la direction de l'objectif
		drone.look_at(coo, Vector3.UP)
		drone2.look_at(coo, Vector3.UP)
		drone3.look_at(coo, Vector3.UP)
	#
	#	# Calcule la vitesse et l'orientation à prendre pour aller vers l'objectif
	#	velocity = (objectif.translation - drone.translation).normalized() * speed
	#	# Si on est loin de l'objectif on continue d'avancer
	#	if (objectif.translation - drone.translation).length() > 3:
	#		velocity = drone.move_and_slide(velocity)
	#	else:
	#		# On est proche de l'objectif on s'arrête
	#		velocity = Vector3.ZERO
		
		
#		update_path(objectif.global_transform.origin)
#		update_path(coo)
		# Use A* Algo
		getAStarPath(coo)
		if current_node < path.size():
			var direction: Vector3 = path[current_node] - drone.global_transform.origin
			if direction.length() < 0.5:
				current_node += 1
			else:
				drone.move_and_slide(direction.normalized() * speed)
				drone2.move_and_slide(direction.normalized() * speed)
				drone3.move_and_slide(direction.normalized() * speed)
		

func update_path(target_position):
	path = navigation.get_simple_path(drone.global_transform.origin, target_position)
#	print(path)

#	drone.translate(Vector3(0,0,0));
#	var vecteur:Vector3 = Vector3(0,0,-abs(drone.translation.z - objectif.translation.z));#drone.translation.x - objectif.translation.x, drone.translation.y - objectif.translation.y, drone.translation.z - objectif.translation.z);
#	print(drone.translation);
#	drone.translate(vecteur*delta);
#	print(drone.get_linear_velocity());
#	print(objectif.translation);
#	drone.add_central_force(vecteur);
#	apply force
#	drone.move_and_slide(vecteur, Vector3.UP*0.1);
