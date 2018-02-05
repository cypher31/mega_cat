extends Node

var player
var main

#power_up
var repel = 1

var bullet = preload("res://scenes/projectile.tscn")
var main_world = preload("res://scenes/main_world.tscn")

var scene_loader = {
	"bullet": bullet,
	"world": main
	}

func _ready():
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
