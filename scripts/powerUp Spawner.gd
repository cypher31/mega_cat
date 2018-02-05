extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var alreadySpawned = false;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	randomize()
	var randomValue = rand_range(1,5);
	var powerUps = ["rapidFire","healthPower","speedPower","repelEnemies","spawnSwarm"];
	print(powerUps[randomValue]);
	
	if !alreadySpawned:
		var powerUp = get_node("/root/global").scene_loader[powerUps[randomValue]].instance();
		add_child(powerUp);
		alreadySpawned = true;
	pass # replace with function body
