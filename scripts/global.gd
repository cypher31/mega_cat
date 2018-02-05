extends Node

var player
var player_score = 0
var main

#power_up
var repel = 1

var bullet = preload("res://scenes/projectile.tscn")
var main_world = preload("res://scenes/main_world.tscn")
var enemy = preload("res://scenes/enemy_.tscn")

var rapidFire = preload("res://scenes/power_up_rapid_fire.tscn")
var healthPower = preload("res://scenes/power_up_health.tscn")
var speedPower = preload("res://scenes/power_up_speed_boost.tscn")
var repelEnemies = preload("res://scenes/power_up_repel_enemies.tscn")
var spawnSwarm = preload("res://scenes/power_up_spawn_swarm.tscn")

var scene_loader = {
	"bullet": bullet,
	"world": main_world,
	"enemy":enemy,
	"rapidFire":rapidFire,
	"healthPower":healthPower,
	"speedPower":speedPower,
	"repelEnemies":repelEnemies,
	"spawnSwarm":spawnSwarm
	}

func _ready():
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
