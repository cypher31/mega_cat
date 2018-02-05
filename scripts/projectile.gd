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
	
	var mousePositionStart = get_global_mouse_position()
	var playerCurrentRotation = player.get_node("Sprite/Position2D").get_rotation()
	
	var direction = (get_global_mouse_position() - get_global_position()).normalized()
	linear_velocity = direction * shotspeed
	
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	
	move_and_slide(linear_velocity);

	pass

func _on_Timer_timeout():
	queue_free();
	pass # replace with function body


func _on_collisionArea_body_entered( body ):
	if body.is_in_group("enemy"):
		body.enemy_health = body.enemy_health - 20;
		
		if(body.enemy_health < 0):
			body.queue_free();
			queue_free();
			print(body.enemy_health);
		pass
		queue_free();
	pass # replace with function body

		