extends KinematicBody2D

var player_speed = 10000
var player_aim
var player_direction_y = 0
var player_direction_x = 0
var player_move = false


func _ready():
	set_process(true)
	pass

func _process(delta):
	look_at(get_global_mouse_position())
	
	#upwards movement
	if Input.is_action_pressed("direction_up"):
		player_direction_y = -1
		player_move = true
	elif Input.is_action_pressed("direction_down"):
		player_direction_y = 1
		player_move = true 
	else:
		player_move = false
		pass
	
	#downwards movement
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
		var velocity_x = player_direction_x * player_speed * delta
		var velocity_y = player_direction_y * player_speed * delta
		
		move_and_slide(Vector2(velocity_x, velocity_y))
		print(global_position)
		pass
	pass
