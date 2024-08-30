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
	get_tree().get_root().print_tree_pretty()
	
	var root_node = get_tree().get_root()

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
			#print(box)
			spring = DampedSpringJoint2D.new()
			spring.position = get_tree().get_root().get_node("Main/Player/Player").global_position
			spring.node_a = get_tree().get_root().get_node("Main/Player/Player").get_path()
			spring.node_b = get_tree().get_root().get_node("Main/Box/Box").get_path()
			spring.length = 5
			spring.rest_length = 5
			spring.stiffness = 10
			get_tree().current_scene.add_child(spring)
			connected = true

func _draw():
	var to = get_viewport_rect().size / 2
	var from = get_viewport().get_mouse_position()
	#draw_line(Vector2(50, 40), Vector2(-150, -40), Color.GREEN, 1.0)
	#draw_line(Vector2(40, 60), Vector2(-140, -90), Color.GREEN, 2.0)
	#draw_line(Vector2(75, 90), Vector2(-175, -140), Color.GREEN, 3.0)
	if connected:
		var player = get_tree().get_root().get_node("Main/Player/Player")
		var box = get_tree().get_root().get_node("Main/Box/Box")

		player_position = player.global_position
		box_position = box.global_position
		draw_line(to, box_position, Color.CORAL, 2.0)
	#draw_line(from, to, Color.DARK_VIOLET, 3.0)


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

	queue_redraw()

	move_and_slide()
		
