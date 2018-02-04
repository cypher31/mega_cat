extends KinematicBody2D

var player
var player_position
var enemy_position
var normalized_movement
var track_player = false

var move_speed = 10000

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
	
	var BA = (player_position - enemy_position).normalized() #enemy to player vector direction
	var BC = (get_node("Sprite/Position2D").global_position - enemy_position).normalized() #enemy facing vector
	var AB = (enemy_position - player_position) #player to enemy vector
	
	if(track_player):
		var velocity = Vector2()
		print(true)
		velocity.x = -move_speed * normalized_movement.x
		velocity.y = -move_speed * normalized_movement.y
			
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
		pass
	pass # replace with function body
