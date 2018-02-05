extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var player
var shotspeed = 1000.0
var linear_velocity

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player  = get_node("/root/global").player
	set_process(true);
	set_as_toplevel(true);
	
	var direction = (get_global_mouse_position() - get_position()).normalized()
	linear_velocity = direction * shotspeed
	
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.

	var mousePositionStart = get_global_mouse_position()
	var playerCurrentRotation = player.get_rotation()
	
	move_and_slide(linear_velocity);

	pass


func _on_Timer_timeout():
	queue_free();
	pass # replace with function body
