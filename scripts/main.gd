extends Node

var player_score

func _ready():
	get_node("/root/global").main = self
	pass

func _power_up(type):
	if type == "repel":
		get_node("/root/global").repel = -1
	elif type == "spawn_swarm":
		
		pass
	
	pass
	

func _add_to_score():
	get_node("/root/global").player_score += 100
	pass

func _on_start_button_button_up():
	var instance = get_node("/root/global").scene_loader["world"].instance()
	
	add_child(instance)
	
	get_node("start_screen").queue_free()
	pass # replace with function body
