extends CharacterBody3D


#I didn't finish this oops
const JUMP_VELOCITY = 4.5
#Speed and camera sensitivity vars
@export var sensitivity_camera = .001
@export var player_speed = 5.0
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D

#Camera effects
@export var camera_fov =50
@export var camera_color = 0
func _unhandled_input(event: InputEvent) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event is InputEventMouseMotion:
		neck.rotate_y(-event.relative.x*sensitivity_camera)
		camera.rotate_x(-event.relative.y*sensitivity_camera)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))
		pass
	pass
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * player_speed
		velocity.z = direction.z * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
		velocity.z = move_toward(velocity.z, 0, player_speed)
	camera.fov=lerp(camera.fov,float(camera_fov),.1)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("test_inp_1"):
		camera_fov +=10
	if Input.is_action_pressed("test_inp_2"):
		camera_fov -=10
	if Input.is_action_just_pressed("exit_test"):
		get_tree().quit()
	pass
