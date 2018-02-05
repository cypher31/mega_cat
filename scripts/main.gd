extends Node

func _ready():
	get_node("/root/global").main = self
	pass

func _power_up(type):
	print(type)
	if type == "repel":
		get_node("/root/global").repel = -1
	elif type == "spawn_swarm":
	
		pass
	
	pass