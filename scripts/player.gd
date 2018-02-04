extends KinematicBody2D

var player_speed = Vector2(1000, 1000)
var player_aim
var player_direction_y = 0
var player_direction_x = 0
var player_move = false


func _ready():
	set_process(true)
	pass

func _process(delta):
	if Input.is_action_pressed("direction_up"):
		player_direction_y = -1
		player_move = true
	elif Input.is_action_pressed("direction_down"):
		player_direction_y = 1
		player_move = true 
	else:
		player_move = false
		pass
	
	if Input.is_action_pressed("direction_left"):
		player_direction_x = -1
		player_move = true
	elif Input.is_action_pressed("direction_right"):
		player_direction_x = 1
		player_move = true
	else:
		player_move = false
		pass
	
	
	if player_move:
		var velocity_x = player_direction_x * player_speed.x * delta
		var velocity_y = player_direction_y * player_speed.y * delta
		
		move_and_slide(Vector2(velocity_x, velocity_y))
		print(global_position)
		pass
	pass
