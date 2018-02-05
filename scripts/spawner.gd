extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var enemy

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	enemy  = get_node("/root/global").enemy
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func _on_Timer_timeout():
	var projectile = get_node("/root/global").scene_loader["enemy"].instance();
	add_child(projectile);
	pass
