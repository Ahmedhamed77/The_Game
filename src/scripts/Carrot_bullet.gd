extends Area2D


var vel = Vector2()
export var Speed = 1000

func _ready() -> void:
	set_process(true)

func start_at(dir,pos):
	set_rotation(dir)
	set_position(pos)
	vel = Vector2(Speed,0).rotated(dir + PI*2)

func _process(delta: float) -> void:
	set_position(get_position()+vel * delta)




func _on_Life_time_timeout() -> void:
	queue_free()
