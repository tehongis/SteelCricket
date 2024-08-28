extends CharacterBody2D

@export var speed = 20
@export var rotation_speed = 2
@export var inertia = 0.97
@export var gravity = 4

var rotation_direction = 0

func get_input():
	#rotation = get_global_mouse_position().angle_to_point(position)
	#rotation_direction = Input.get_axis("move_left", "move_right")
	velocity.x += Input.get_axis("move_left", "move_right") * speed
	velocity.y += Input.get_axis("move_up", "move_down") * speed

func _physics_process(delta):
	get_input()
	#rotation += rotation_direction * rotation_speed * delta

#	velocity.x = lerp(velocity.x, 0, 0.02)
#	velocity.y = lerp(velocity.y, 0, 0.02)

	if is_on_floor():
		velocity.x = 0

	velocity.x = velocity.x * inertia
	velocity.y = velocity.y * inertia

	velocity.y += gravity

	move_and_slide()
