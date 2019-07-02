extends KinematicBody2D

export (int) var gravity
export (int) var rotSpeed
export (int) var thrust

export (int) var maxAngle

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	thrust = pow(gravity, 3)

# gets player input
func get_input():
	if (Input.is_action_pressed("left") || Input.is_action_pressed("right")):
		velocity = Vector2(0, -thrust).rotated(rotation_degrees)
	elif is_on_ceiling():
		velocity = Vector2(0, 0)
	else:
		velocity.x = lerp(velocity.x, 0, 0.1)

	if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
			rotation_degrees = max(lerp(rotation_degrees, rotation_degrees - rotSpeed, 0.9), -maxAngle)
	elif Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
			rotation_degrees = min(lerp(rotation_degrees, rotation_degrees + rotSpeed, 0.9), maxAngle)
	else:
		rotation /= 2
		if abs(rotation_degrees) < .25:
			rotation_degrees = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
	get_input()
	move_and_slide(velocity)

func _process(delta):
	pass