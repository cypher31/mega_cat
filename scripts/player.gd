extends KinematicBody2D

var player_aim
var player_direction_y = 0
var player_direction_x = 0
var player_move = false

var player_health = 100
var player_speed = 10000
var player_shot_speed
var sprite_array = []

#power_up_mods multipliers to timers
var speed_boost = 1.5
var rapid_fire = 2
var health_pack = 25
var enemy_repel = -1
var spawn_swarm = 2.5

#player score
var player_score = 0

#bools
var can_shoot = true

#signal
signal repel
signal spawn_swarm

func _ready():
	get_node("/root/global").player = self;
	set_process(true)
	
	set_process_input(true);
	
	#connect signals
	connect("repel", get_node("/root/global").main, "_power_up")
	connect("spawn_swarm", get_node("/root/global").main, "_power_up")
	
	for i in range(1, 9):
		sprite_array.append(load("res://Assets/player_sprite/player_sprite"  + "_" + str(i) + ".png"))
		#print(i)

	pass

func _process(delta):
	_rotate_sprite()
	look_at(get_global_mouse_position())
	
	#update ui
	get_node("CanvasLayer/TextureProgress").set_value(player_health)
	get_node("CanvasLayer/score").set_text(str(get_node("/root/global").player_score))
	
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
	if event.is_action_pressed("shoot") and can_shoot:
		get_node("shot_timer").start()
		can_shoot = false
		
		var projectile = get_node("/root/global").scene_loader["bullet"].instance();
		add_child(projectile);
		
		projectile.set_global_position(get_node("Position2D").get_global_position())

	pass


func _power_up(type):
	if type == "power_up_health":
		player_health = clamp(player_health + health_pack, 0, 100)
	elif type == "power_up_rapid_fire":
		get_node("shot_timer").set_wait_time(get_node("shot_timer").get_wait_time() / rapid_fire)
		get_node("power_up_timer").set_wait_time(10)
		get_node("power_up_timer").start()
	elif type == "power_up_speed_boost":
		player_speed *= speed_boost
		get_node("power_up_timer").set_wait_time(10)
		get_node("power_up_timer").start()
	elif type == "power_up_repel_enemies":
		emit_signal("repel", "repel")
		get_node("power_up_timer").set_wait_time(10)
		get_node("power_up_timer").start()
	elif type == "power_up_spawn_swarm":
		emit_signal("spawn_swarm", "spawn_swarm")
		get_node("power_up_timer").set_wait_time(10)
		get_node("power_up_timer").start()
		pass
	pass
	

func knock_back(normal):
	set_global_position(get_global_position() - normal * 100)
	
	pass



func _rotate_sprite():
	var sprite_rot = rad2deg(get_global_rotation())
	
	var start = -90
	var rot_mod = 45 / 2
	#print(sprite_rot)
	#print(start - rot_mod)
	if sprite_rot > (-112.5) and sprite_rot < (-67.5) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[0])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(90))
		get_node("Sprite").set_flip_h(false)
	elif sprite_rot > (-157.5) and sprite_rot < (-112.5) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[1])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(90+45))
		get_node("Sprite").set_flip_h(false)
	elif sprite_rot > (-180) and sprite_rot < (-157.5) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[2])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(90+45+22.5))
		get_node("Sprite").set_flip_h(true)
	elif sprite_rot < (180) and sprite_rot > (157.5) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[2])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(90+45+22.5))
		get_node("Sprite").set_flip_h(true)
	elif sprite_rot < (157.5) and sprite_rot > (117.5) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[3])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90-45-22.5))
		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (117.5) and sprite_rot > (117.5 - 45) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[4])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90))
		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (72.5) and sprite_rot > (72.5 - 45) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[5])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5))
		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (72.5 - 45) and sprite_rot > (0) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[6])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5+22.5))
		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (0) and sprite_rot > (-22.5) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[6])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5+22.5))
		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (-22.5) and sprite_rot > (-22.5-45) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[7])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5+22.5+22.5))
		get_node("Sprite").set_flip_h(false)
	pass


func _on_collision_area_body_entered( body ):
	if body.is_in_group("enemy"):
		var enemy_position = body.get_global_position()
		var relative_position = enemy_position - get_global_position()
		
		var normal = relative_position.normalized()
		knock_back(normal)
		player_health -= 10
		
		if player_health <= 0:
			get_tree().reload_current_scene()
			pass
		pass
	pass # replace with function body


func _on_collision_area_area_entered( area ):
	if area.is_in_group("power_up"):
		_power_up(area.type)
		area.queue_free()
	pass # replace with function body
	
	
func _on_shot_timer_timeout():
	can_shoot = true
	pass # replace with function body

