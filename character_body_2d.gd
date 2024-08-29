extends CharacterBody2D

@export var speed = 40
@export var rotation_speed = 2
@export var inertia = 0.97

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var rotation_direction = 0

var connected = false
var spring = null

var player_position = null
var box_position = null

func _ready():
	var root_node = get_parent()
	var player = root_node.get_node("Player")
	var box = root_node.get_node("Box")
	player_position = player.global_position
	box_position = box.global_position

func get_input():
	#rotation = get_global_mouse_position().angle_to_point(position)
	#rotation_direction = Input.get_axis("move_left", "move_right")
	velocity.x += Input.get_axis("move_left", "move_right") * speed
	velocity.y += Input.get_axis("move_up", "move_down") * speed

	if Input.is_action_just_pressed("grapple"):
		if connected:
			get_tree().current_scene.remove_child(spring)
			connected = false
		else:
			var box = get_node("../Box")
			#print(box)
			spring = DampedSpringJoint2D.new()
			spring.position = Vector2.ZERO
			spring.node_a = self.get_path()
			spring.node_b = box.get_path()
			spring.length = 2
			spring.rest_length = 0
			spring.stiffness = 1
			get_tree().current_scene.add_child(spring)
			connected = true


func _physics_process(delta):
	get_input()
	#rotation += rotation_direction * rotation_speed * delta

#	velocity.x = lerp(velocity.x, 0, 0.02)
#	velocity.y = lerp(velocity.y, 0, 0.02)

	velocity.y += gravity * delta

	if is_on_floor():
		velocity.x = 0

	velocity.x = velocity.x * inertia
	velocity.y = velocity.y * inertia

	move_and_slide()

func _draw():
	if connected:
		draw_line(player_position, box_position, Color.GREEN, 1.0)
