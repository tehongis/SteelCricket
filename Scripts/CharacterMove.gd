extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Vibration parameters
var weak_magnitude = 0.5
var strong_magnitude = 1.0
var duration = 0.5  # in seconds
var rotation_speed := 3.0

var target_rotation = Vector3();


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * -1
		velocity.z = direction.z * SPEED * -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

# Rotate character

	rotation_degrees = Vector3(0,lerp(rotation_degrees.y,target_rotation.y,rotation_speed*delta),0)

	var rotation_velocity = Input.get_axis("turn_left", "turn_right") 
	if Input.is_action_just_pressed("turn_left"):
		target_rotation = target_rotation -  Vector3(0,90,0)
		
	if Input.is_action_just_pressed("turn_right"):
		target_rotation = target_rotation +  Vector3(0,90,0)

# Vibration effects

	if Input.is_action_just_pressed("trigger_left"):
		Input.start_joy_vibration(0, weak_magnitude/4, strong_magnitude/4, 0)

	if Input.is_action_just_pressed("trigger_right"):
		Input.start_joy_vibration(0, weak_magnitude, strong_magnitude, 0)

	if Input.is_action_just_released("trigger_left"):
		Input.stop_joy_vibration(0)

	if Input.is_action_just_released("trigger_right"):
		Input.stop_joy_vibration(0)



	move_and_slide()
