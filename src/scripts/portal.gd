tool
extends Area2D

onready var anim_player: AnimationPlayer =  $AnimationPlayer
export var next_scene:  PackedScene

func _on_body_entered(body): ## so when the player touch the area of the collasion here ,moves to the next scene 
	get_tree().change_scene_to(next_scene)

func _get_configuration_warning(): ## just a warning messege to the coder
	return "The Next Scene property can't be empty" if not next_scene else ""

func teleport(): ## when the player go inside the portal we need it to fade out and when it moves to the next scene it should fade in again
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
