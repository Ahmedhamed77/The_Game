extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseWhenCLicked")
onready var score: Label = get_node("Label")
onready var pause_text: Label = get_node("PauseWhenCLicked/Text")

var paused: = false setget set_paused

func _ready() -> void:
	PlayerData.connect("score_updated",self,"update_interface")
	PlayerData.connect("player_died",self,"_on_playerData_played_died")
	update_interface()

func _on_playerData_played_died() -> void:
	self.paused = true
	pause_text.text = "You died"

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") and pause_text.text != "You died":
		self.paused = not paused
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	score.text ="SCore: %s" % PlayerData.score

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
