extends KinematicBody2D

var player_speed = 10000
var player_aim
var player_direction_y = 0
var player_direction_x = 0
var player_move = false


func _ready():
	get_node("/root/global").player = self;
	set_process(true)
	
	set_process_input(true);
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

	 #downwards movement
	if Input.is_action_pressed("direction_left"):
		player_direction_x = -1
		player_move = true
	elif Input.is_action_pressed("direction_right"):
		player_direction_x = 1
		player_move = true
	
	if(!Input.is_action_pressed("direction_up") && !Input.is_action_pressed("direction_down")
	&& !Input.is_action_pressed("direction_left") && !Input.is_action_pressed("direction_right")):
		player_move = false;
		
		
	if !Input.is_action_pressed("direction_up") and !Input.is_action_pressed("direction_down"):
		player_direction_y = 0
		pass
		
	if !Input.is_action_pressed("direction_right") and !Input.is_action_pressed("direction_left"):
		player_direction_x = 0
		pass
		
	if player_move:
		var velocity_x = player_direction_x * player_speed * delta
		var velocity_y = player_direction_y * player_speed * delta
		
		move_and_slide(Vector2(velocity_x, velocity_y))
		#print(global_position)
		pass
		
	pass

func _input(event):
	if event.is_action_pressed("shoot"):
		var projectile = get_node("/root/global").scene_loader["bullet"].instance();
		add_child(projectile);
#		instance.set_global_position(global_position);
	pass


func knock_back(normal):
	set_global_position(get_global_position() - normal * 100)
	
	pass

func _on_collision_area_body_entered( body ):
	if body.is_in_group("enemy"):
		var enemy_position = body.get_global_position()
		var relative_position = enemy_position - get_global_position()
		
		var normal = relative_position.normalized()
		knock_back(normal)
		pass
	pass # replace with function body
