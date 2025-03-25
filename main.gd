extends Node2D
var open_player = preload("res://Player/Player.tscn")
var load_warding = preload("res://Warding/Warding.tscn")
var warding

func _ready():

	
	warding = load_warding.instantiate()
	warding.position = Vector2(360,960)
	add_child(warding)
	
	var player = open_player.instantiate()
	player.scale = Vector2(.6,.6)
	player.position = Vector2(360,960)
	add_child(player)
	
	
	

#func _process(delta):
	#warding.scale += Vector2(.001,.001)
	#coll.scale += Vector2(.001,.001)
