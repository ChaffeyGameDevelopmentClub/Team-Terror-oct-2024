extends CharacterBody3D

#SFX
@export var Walk: AudioStreamPlayer
@export var Run: AudioStreamPlayer
#I didn't finish this oops
const JUMP_VELOCITY = 4.5
#Speed and camera sensitivity vars
@export var sensitivity_camera = .001
@export var player_speed = 2.5
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var health = 2
@onready var stamina=100
@onready var isSprint= false
@onready var isTired= false
@onready var isSound= false
#Camera effects
@export var camera_fov =50
@export var camera_color = 0

func _unhandled_input(event: InputEvent) -> void:
	clamp(stamina,0,200)
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
	if direction and isSprint==true and isTired!=true:
		stamina -= 2
	else:
		if stamina < 200:
			stamina +=1
	if stamina <10:
		isTired=true
	elif stamina>180:
		isTired=false
	
	move_and_slide()
func _on_body_entered(body: Node3D) -> void:
	if body.get_name() == "door_transition":
		SceneTransition.scene_transition_cloud("res://Player/Test World/test_level_player_movement_lol.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("test_inp_1"):
		camera_fov +=10
	if Input.is_action_pressed("test_inp_2"):
		camera_fov -=10
	if Input.is_action_just_pressed("exit_test"):
		get_tree().quit()
	if Input.is_action_pressed("sprint") and isTired==false:
		player_speed = 6
		isSprint=true
	else: 
		player_speed = 2.5
		isSprint=false
	if velocity.x!=0 and velocity.z!=0 and isSound != true and is_on_floor():
		isSound = true
		Walk.play()
		await(Walk.finished)
		isSound=false
		pass
	if Input.is_action_just_pressed("test3"):
		SceneTransition.scene_transition_cloud("res://Player/Test World/test_level_player_movement_lol.tscn")
	pass
