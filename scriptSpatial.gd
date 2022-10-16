extends Spatial

var droneObject = preload("res://Drone.tscn");
var drone:KinematicBody = null;
var objectifObject = preload("Objectif.tscn");
var objectif:RigidBody = null;
#var drones:RigidBody[] = [];
var coordonnees = Vector3(0,10,0);
var objectifCoordonnees = coordonnees;
var vitesse_rotation:float = PI;

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	if drone == null:
		drone = droneObject.instance();
		drone.translation = coordonnees;
		add_child(drone);
	
	if objectif == null:
		genereObjectif();

func genereObjectif():
	var x = rand_range(-40,40);
	var z = rand_range(-40,40);
	objectifCoordonnees = Vector3(x,objectifCoordonnees.y,z);
	objectif = objectifObject.instance();
	objectif.translation = objectifCoordonnees;
	#Insertion objectif dans la scène principale
	add_child(objectif);

func _input(ev):
	if ev is InputEventKey and ev.scancode == KEY_SPACE and ev.is_pressed():
		if objectif != null:
			objectif.queue_free();
		genereObjectif();

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
func _physics_process(delta):
	# Permet au drone de regarder dans la direction de l'objectif
	drone.look_at(objectif.translation,Vector3.UP)
	
	# Calcule la vitesse et l'orientation à prendre pour aller vers l'objectif
	velocity = (objectif.translation - drone.translation).normalized() * speed
	# Si on est loin de l'objectif on continue d'avancer
	if (objectif.translation - drone.translation).length() > 3:
		velocity = drone.move_and_slide(velocity)
	else:
		# On est proche de l'objectif on s'arrête
		velocity = Vector3.ZERO



#	drone.translate(Vector3(0,0,0));
#	var vecteur:Vector3 = Vector3(0,0,-abs(drone.translation.z - objectif.translation.z));#drone.translation.x - objectif.translation.x, drone.translation.y - objectif.translation.y, drone.translation.z - objectif.translation.z);
#	print(drone.translation);
#	drone.translate(vecteur*delta);
#	print(drone.get_linear_velocity());
#	print(objectif.translation);
#	drone.add_central_force(vecteur);
#	apply force
#	drone.move_and_slide(vecteur, Vector3.UP*0.1);
