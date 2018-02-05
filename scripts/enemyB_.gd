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

var sprite_array = []

signal hit_player

func _ready():
	set_process(true)
	
	
	player = get_node("/root/global").player
	
	for i in range(1, 9):
		sprite_array.append(load("res://Assets/dog_sprite/dog" + str(i) + ".png"))
		#print(i)	
	pass

func _process(delta):
	
	_rotate_sprite()
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
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot > (-157.5) and sprite_rot < (-112.5) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[1])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(90+45))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot > (-180) and sprite_rot < (-157.5) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[2])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(90+45+22.5))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (180) and sprite_rot > (157.5) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[2])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(90+45+22.5))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (157.5) and sprite_rot > (117.5) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[3])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90-45-22.5))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (117.5) and sprite_rot > (117.5 - 45) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[4])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (72.5) and sprite_rot > (72.5 - 45) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[5])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (72.5 - 45) and sprite_rot > (0) and sprite_rot > 0:
		get_node("Sprite").set_texture(sprite_array[6])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5+22.5))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (0) and sprite_rot > (-22.5) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[6])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5+22.5))
#		get_node("Sprite").set_flip_h(false)
	elif sprite_rot < (-22.5) and sprite_rot > (-22.5-45) and sprite_rot < 0:
		get_node("Sprite").set_texture(sprite_array[7])
		set_rotation(-(45 + 22.5))
		get_node("Sprite").set_rotation(deg2rad(-90+45+22.5+22.5+22.5))
#		get_node("Sprite").set_flip_h(false
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
		randomize()
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
