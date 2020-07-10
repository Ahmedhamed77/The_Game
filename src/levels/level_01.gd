extends Node2D

func _ready():
	get_tree().paused =  false  ## a line of code fixing the error of inside the game of the ESC button when the game is paused it started to crash because the pause button become true
