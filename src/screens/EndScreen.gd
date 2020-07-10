extends Control

onready var label: Label = $Label
## just an end screen to show the scroe to the player and ask him whether he want to play again or no.
func _ready() -> void:
	label.text = label.text % [PlayerData.score]
