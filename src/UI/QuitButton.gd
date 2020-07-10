extends Button

func _on_QuitButton_button_up() -> void:
	get_tree().quit() ## just we call the node to quite when it pressed
