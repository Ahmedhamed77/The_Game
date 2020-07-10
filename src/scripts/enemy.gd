extends "res://src/scripts/actor.gd"


export var score  = 100

func _ready():
#	set_physics_process(false)
	velocity.x = -speed.x
	$Sprite.flip_h = true
		
		
## this function to detecet the area where which the player gonna hit so the enemy will die
func _on_StompDetector_body_entered(body):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	$CollisionShape2D.set_deferred("disabled", true)
	die()


## we create the move and the gravity to the enemy
func _physics_process(delta):
	velocity.y += gravity * delta
	if is_on_wall():
		velocity.x *= -1.0
		$Sprite.flip_h = !$Sprite.flip_h
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y

## a function to let the enemy die
func die() -> void:
	queue_free()
	PlayerData.score += score
