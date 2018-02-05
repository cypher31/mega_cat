extends KinematicBody2D

var player
var player_position
var enemy_position
var normalized_movement
var track_player = false

var move_speed = 10000

var enemy_health = 100
var randX
var randY

var move_random = false;
var timer;

signal hit_player

func _ready():
	set_process(true)
	
	player = get_node("/root/global").player
	pass

func _process(delta):
	player_position = player.global_position
	
	look_at(player_position)

	enemy_position = global_position

	var relative_position = (enemy_position - player_position)
	normalized_movement = relative_position.normalized()
	
	if(track_player):
		var velocity = Vector2()
		velocity.x = -move_speed * normalized_movement.x
		velocity.y = -move_speed * normalized_movement.y
			
		var motion = velocity * delta * get_node("/root/global").repel #calculation motion
		
		move_and_slide(motion) #apply motion
		pass
	elif move_random:
		get_node("Timer2").start()
		
		var velocity = Vector2()
		
		
		var newPosition = Vector2(enemy_position.x + (randX),enemy_position.y + (randY));
		relative_position = (enemy_position - newPosition);
		normalized_movement = relative_position.normalized();
		
		velocity.x = -move_speed * (normalized_movement.x)
		velocity.y = -move_speed * (normalized_movement.y)
		
		var motion = velocity * delta #calculation motion
		
		move_and_slide(motion) #apply motion
		pass
	pass


func _on_Area2D_body_entered( body ):
	if body.is_in_group("player"):
		track_player = true
		pass
	pass # replace with function body


func _on_Area2D_body_exited( body ):
	if body.is_in_group("player"):
		track_player = false
		get_node("Timer").start()
		pass
	pass # replace with function body


func _on_Timer_timeout():
	if !track_player:
		randX = rand_range(-35,45)
		randY = rand_range(-35,45)
		move_random = true;
		pass
	pass # replace with function body


func _on_Timer2_timeout():
	timer = get_node("Timer")
	
	timer.start();
	move_random = false;
	pass # replace with function body
