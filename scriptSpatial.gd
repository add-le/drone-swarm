extends Spatial

# Constantes
const NB_DRONE = 10
const AXE_Y = 30
const SPEED = 0.5

# Récupère les différentes nodes
onready var camera: Camera = $Camera
onready var lblmode: Label = $Control/Mode

# Charge la scene du drone
var droneObject = preload("res://Drone/untitled.tscn");
var drones = []

# A* Algorithm
var astar: AStar = AStar.new()
var random: RandomNumberGenerator = RandomNumberGenerator.new()

# Variables globales
var coo = null
var mode = "attraction"

# Obtient la position des drones quand ils attendent sur un point
func getDroneIdlePosition():
	var x0 = coo.x
	var y0 = coo.z
	var r = 10
	
	var positions = []
	
	for i in range(0, NB_DRONE):
		var x = x0 + r * cos(2 * PI * i / NB_DRONE)
		var y = y0 + r * sin(2 * PI * i / NB_DRONE)
		positions.append(Vector3(x, AXE_Y, y))
	return positions


# Créer n drones
func generateDrone(n):
	for i in range(0, n):
		var obj = droneObject.instance()
		var x = random.randi_range(-100, 100)
		var z = random.randi_range(-100, 100)
		obj.translation = Vector3(x, AXE_Y, z)
		add_child(obj)
		drones.append(obj)


# Fonction init du script
func _ready():
	# Reset la seed de l'aléatoire
	randomize()
	# Place les drones sur la scene
	generateDrone(NB_DRONE)


# Génère le chemin entre le drone et l'objectif avec l'algorithme AStar
func getAStarPath():
	var positions = getDroneIdlePosition()
	for i in range(0, NB_DRONE):
		astar.add_point(0, drones[i].global_transform.origin)
		astar.add_point(1, positions[i])
		astar.connect_points(0, 1, false)
		
		if astar.are_points_connected(0, 1, false):
			drones[i].path = astar.get_point_path(0, 1)


# Fonction des entrées souris et clavier
func _input(ev: InputEvent):
	# Changer le mode des drones
	if ev is InputEventKey and ev.scancode == KEY_A and ev.is_pressed():
		if mode == "attraction":
			mode = "repulsion"
		elif mode == "repulsion":
			mode = "attraction"
		lblmode.text = "Mode : " + mode
	
	# Place l'objectif à l'endroit du clic
	if ev is InputEventMouseButton and ev.button_index == BUTTON_LEFT and ev.is_pressed():
		# Récupère les coordonnées du clic de la souris
		coo = camera.project_position(ev.position, 10)
		coo.y = AXE_Y
		for i in range(0, NB_DRONE):
			drones[i].current_node = 0


# Fonction actualisation de la scene et de sa physique
func _physics_process(delta):
	if coo != null:
		# Permet au drone de regarder dans la direction de l'objectif
		for i in range(0, NB_DRONE):
			drones[i].look_at(coo, Vector3.UP)

		# Créer le chemin entre le drone et l'objectif
		getAStarPath()
		for i in range(0, NB_DRONE):
			if drones[i].current_node < drones[i].path.size():
				var direction: Vector3 = drones[i].path[drones[i].current_node] - drones[i].global_transform.origin
				if direction.length() < 0.5:
					drones[i].current_node += 1
				else:
					# Permet de voler par dessus les autres drones, si ils sont dans le chemin
					var collisions = drones[i].move_and_collide(direction * delta * SPEED)
					if collisions:
						direction.y = direction.y + 10
						drones[i].move_and_collide(direction * delta * SPEED)

