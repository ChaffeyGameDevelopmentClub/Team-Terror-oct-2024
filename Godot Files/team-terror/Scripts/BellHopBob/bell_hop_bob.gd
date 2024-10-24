extends CharacterBody3D


var SPEED = 2.0

var player = null
@export var playerNode : CharacterBody3D
@export var nav_agent : NavigationAgent3D
@export var seenTimer : Timer
@export var stalkingTimer : Timer
@export var wanderTimer : Timer
@export var idleTimer : Timer
@export var sight : RayCast3D
@export var ani : AnimationPlayer

@onready var testingTimer = $"Testing Timer"
var seen : bool
var idleTimerStarted : bool
var stalkingTimerStarted : bool
var seenTimerStarted : bool
var randomPos
var wandertime
#States
enum ENTITY_STATE{
	IDLE,
	CHASE,
	STALKING,
	WANDERING
}
@export var entity_state = ENTITY_STATE.IDLE


func _ready():
	randomPos = setRandomPos()
	wandertime = wanderTimer.wait_time
func _process(delta):
	#reset velocity
	velocity = Vector3.ZERO
	#If player is seen
	if sight.get_collider() == playerNode:
		seen = true
	else:
		
		seen = false
	#Change state
	if seen == true:
		entity_state = 1
	#States
	match entity_state:
		0: #Idle
			SPEED = 1.0
			ani.play('BobAnimations/Walk')
			#Stop moving for a little
			if idleTimerStarted == false:
				idleTimer.start()
				idleTimerStarted = true
			#Switch to wander on idle timeout
			
			pass
		1: #Chase - When seen/Heard
			SPEED = 5
			ani.play('BobAnimations/Run')
			#Get players location
			setTarget(playerNode.global_transform.origin)
			#move to location
			look_at(playerNode.global_transform.origin)
			moveTo()
			#If player is out of los
			if seen == false and seenTimerStarted == false:
				seenTimer.start()
				seenTimerStarted = true
				#Wander
			
			
		2: #Stalking - Get closer to player
			SPEED = 1.0
			ani.play('BobAnimations/Walk')
			#Get Players Pos
			setTarget(playerNode.global_transform.origin)
			#Move To
			
			look_at(playerNode.global_transform.origin)
			moveTo()
			#Start Timer
			if stalkingTimerStarted == false:
				stalkingTimer.start()
				stalkingTimerStarted = true
			
			
		3: #Wandering
			SPEED = 1.0
			ani.play('BobAnimations/Walk')
			#Find random Pos
			if(abs(randomPos.x - global_position.x) <= 10 and abs(randomPos.z - global_position.z) <= 10) or wanderTimer.time_left <=0:
				randomPos = setRandomPos()
				wanderTimer.wait_time = wandertime
				wanderTimer.start()
			#set Target
			setTarget(randomPos)
			#Move to
			moveTo()
			lookAt(global_transform.origin + velocity)
			#on target Reached reset or on timeout

	move_and_slide()

#Functions
func lookAt(target):
	look_at(Vector3(target.x,3.6,target.z))

func setTarget(target):
	nav_agent.set_target_position(target)

func moveTo():
	var next_nav_point = nav_agent.get_next_path_position()
	var Newvelocity = (next_nav_point - global_transform.origin).normalized() * SPEED
	set_velocity(Newvelocity)

func setRandomPos():
	var pos = Vector3(randf_range(playerNode.global_position.x-40, playerNode.global_position.x+40), position.y,
		 		randf_range(playerNode.global_position.z-40, playerNode.global_position.z+40))
	print_debug(pos)
	return pos

#timers
func _on_idle_timer_timeout() -> void:
	#switch to wander
	print_debug("Idle Timeout")
	var randint = randi_range(1,2)
	if randint == 1 :
		#chance to switch to stalking
		entity_state = 2
	else:
		entity_state = 3
	idleTimerStarted = false

func _on_seen_timer_timeout() -> void:
	#switch to wander
	seenTimerStarted = false
	entity_state = 3

func _on_stalking_timer_timeout() -> void:
	#Swtich to wander
	stalkingTimerStarted = false
	entity_state = 3

func _on_wander_timer_timeout() -> void:
	#Swtich to idle
	entity_state = 0

#testing stuff
func _on_testing_timer_timeout() -> void:
	if entity_state == 0:
		print_debug("idle")
	elif entity_state == 1:
		print_debug("Chase")
	elif entity_state == 2:
		print_debug("Stalking")
	elif entity_state == 3:
		print_debug("wandering")
	#print(idleTimer.time_left)
	if seen == false:
		print('not seen')
	print_debug(seenTimer.time_left)
	print_debug(nav_agent.distance_to_target())

#signals
func _on_hearing_body_entered(body: Node3D) -> void:
	#set to chase
	if body.name == 'Player':
		entity_state = 1


func _on_hearing_body_exited(body: Node3D) -> void:
	pass # Replace with function body.

func _on_kill_body_entered(body: Node3D) -> void:
	if body.name == 'Player':
		get_tree().change_scene_to_file('res://Scenes/Ui/menus/main_menu/main_menu_with_animations.tscn')
		print_debug('Player Killed')
		pass
		


func _on_kill_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
