extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var player
var shotspeed = 1000.0
var linear_velocity

signal enemy_dead

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player  = get_node("/root/global").player
	set_process(true);
	set_as_toplevel(true);
	
	var mousePositionStart = get_global_mouse_position()
	var playerCurrentRotation = player.get_node("Position2D").get_rotation()
	
	var direction = (get_global_mouse_position() - get_global_position()).normalized()
	linear_velocity = direction * shotspeed
	
	connect("enemy_dead", get_node("/root/global").main, "_add_to_score")
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
			emit_signal("enemy_dead")
		pass
		
	linear_velocity = Vector2(0,0)
	get_node("AnimationPlayer").play("hit")
	pass # replace with function body

		

func _on_AnimationPlayer_animation_finished( anim_name ):
	if anim_name == "hit":
		queue_free()
		pass
	pass # replace with function body
