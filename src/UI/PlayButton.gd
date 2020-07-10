extends Button


export(String,FILE) var next_scene: = ""

func _on_PlayButton_button_up() -> void:
	get_tree().change_scene(next_scene)
	get_tree().paused = false
