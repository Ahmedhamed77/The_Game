extends Button

func _on_PlayButton_button_up() -> void:
	PlayerData.score = 0  ## when the player press retry the score back to 0
	get_tree().paused = false ## and the pause menu fade out again
	get_tree().reload_current_scene() ## and this to relod the next scene
