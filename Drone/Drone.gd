extends KinematicBody


export (Array) var path = []
export (int) var current_node = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim1 = $AnimationPlayer
onready var anim2 = $AnimationPlayer2
onready var anim3 = $AnimationPlayer3
onready var anim4 = $AnimationPlayer4

# Called when the node enters the scene tree for the first time.
func _ready():
	anim1.play("MeshInstance001Action")
	anim2.play("DroneMeshInstance002Action")
	anim3.play("DroneMeshInstance003Action")
	anim4.play("DroneMeshInstance004Action")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
