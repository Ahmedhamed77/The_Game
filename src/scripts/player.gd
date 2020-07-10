extends Actor

export var stomp_impulas = 1000.0
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

var screen_size # Size of the game window.


export(PackedScene) var bullet   ## just in case we need to add bullets
onready var bullet_container = get_node("Bullet_container")


func _on_EnemyDetector_area_entered(area):     
	velocity = calculate_stomp_velocity(velocity, stomp_impulas)

func _on_EnemyDetector_body_entered(body):  ## when the player touchs the enemy the player die
  #get_tree().reload_current_scene()
	die()


## here we add the animation of the player when it stands when the player is running , just some animation to the player

func animate():
	if Input.is_action_pressed("ui_up"):
		anim_player.play("jump")
	
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		anim_player.play("running")
		
		if Input.is_action_pressed("ui_left"): $Sprite.flip_h = true
		if Input.is_action_pressed("ui_right"): $Sprite.flip_h = false
		
	else: anim_player.play("default")


## here we create how the player can move , up - right - left , the velocity and the gravity so the player always stucks to the floor
 
func _physics_process(delta):
	
	var is_jump_interrupted = Input.is_action_just_released("ui_up") and velocity.y < 0.0
	var direction = get_direction()
	
	velocity = calculate_move_velocity(velocity, speed, direction, is_jump_interrupted)
	velocity = 	move_and_slide(velocity, FLOOR_NORMAL)
	#if Input.is_action_pressed("Player_shoot"):  ## just in case we usde bullets and shooting 
	#	shoot()
	animate()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-1.0 if Input.get_action_strength("ui_up") and is_on_floor() else 0.0
	)

## the basic function of moving and jumping and how far the player can jump 
func calculate_move_velocity(
	linear_velocity: Vector2,
	speed: Vector2,
	direction: Vector2,
	is_jump_interrupted: bool
) -> Vector2:
	
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if direction.y == -1.0: new_velocity.y = speed.y * direction.y
	
	if is_jump_interrupted: new_velocity.y = 0.0
	
	return new_velocity
	
func calculate_stomp_velocity(linear_velocity: Vector2, impulas: float):
	var out: = linear_velocity
	out.y = - impulas
	return out


## when the player go out of the screen, the player dies
func _on_VisibilityNotifier2D_screen_exited() -> void:
	die()


func die() -> void:
	PlayerData.deaths += 1 ## increasing the death by 1 when the player die
	queue_free()  ## the player die

## incase of we use shooting
#func shoot():
#	var b = bullet.instance()
#	bullet_container.add_child(b)
#	b.start_at(get_rotation(),get_position())


