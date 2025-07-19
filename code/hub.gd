extends Node2D

var playerName:String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_environment("USER"):
		playerName = OS.get_environment("USER")
	elif OS.has_environment("USERNAME"):
		playerName = OS.get_environment("USERNAME")
	
	$Label.text = "Hello, "+var_to_str(playerName)
