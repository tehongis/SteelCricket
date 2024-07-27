extends CharacterBody2D

# Speed of the player
var speed = 500

# Vibration parameters
var weak_magnitude = 0.5
var strong_magnitude = 1.0
var duration = 0.5  # in seconds

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).limit_length(1.0)

	velocity = input_vector * speed * delta
	move_and_slide()

	if Input.is_action_just_pressed("trigger_left"):
		Input.start_joy_vibration(0, weak_magnitude/4, strong_magnitude/4, duration*2)

	if Input.is_action_just_pressed("trigger_right"):
		Input.start_joy_vibration(0, weak_magnitude, strong_magnitude, duration)

