extends CharacterBody2D

@export var speed = 200
@export var rotation_speed = 2

var rotation_direction = 0

func get_input():
	#rotation = get_global_mouse_position().angle_to_point(position)
	rotation_direction = Input.get_axis("move_left", "move_right")
	velocity = transform.x * Input.get_axis("move_down", "move_up") * speed

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
