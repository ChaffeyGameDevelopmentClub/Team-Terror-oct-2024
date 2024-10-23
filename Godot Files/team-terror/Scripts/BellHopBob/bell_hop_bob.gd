extends CharacterBody3D


const SPEED = 1.0

var player = null
@export var playerNode : CharacterBody3D
@export var nav_agent : NavigationAgent3D
@export var seenTimer : Timer
@export var stalkingTimer : Timer
@export var sight : RayCast3D
var seen : bool

#States
enum ENTITY_STATE{
	IDLE,
	CHASE,
	STALKING,
	WANDERING
}
@export var entity_state = ENTITY_STATE.IDLE


func _ready():
	pass
func _process(delta):
	velocity = Vector3.ZERO
	
	if sight.get_collider() == playerNode:
		seen = true
	
	
	if seen == false:
		entity_state = 0
	if seen == true:
		entity_state = 1
	#States
	match entity_state:
		0: #Idle
			#Check for player
			#
			
			pass
		1: #Chase - When seen/Heard
			#Get players location
			nav_agent.set_target_position(playerNode.global_transform.origin)
			#move to location
			var next_nav_point = nav_agent.get_next_path_position()
			var Newvelocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			look_at(playerNode.global_transform.origin)
			set_velocity(Newvelocity)
			#If player is out of los
			if seen == false:
				seenTimer.start()
				#Wander
			
			pass
		2: #Stalking
			#Get Players Pos
			nav_agent.set_target_position(playerNode.global_transform.origin)
			#Move To
			var next_nav_point = nav_agent.get_next_path_position()
			var Newvelocity = (next_nav_point - global_transform.origin).normalized() * SPEED
			look_at(playerNode.global_transform.origin)
			set_velocity(Newvelocity)
			#Start Timer
			stalkingTimer.start()
			
		3: #Wandering
			#Find random Pos
			#set Target
			#Move to
			#on target Reached reset or on timeout
			pass
	
	#Nav moving
	
	
	move_and_slide()

func lookAt(target):
	self.rotate_y(1)
	
func _on_seen_timer_timeout() -> void:
	#switch to wander
	entity_state = 3

func _on_stalking_timer_timeout() -> void:
	#Swtich to wander
	entity_state = 3


'
func look_at(target):
	pass

func chase():
	look_at(player.position)
	nav_agent.target_position = player.global_position

func wandering():
	look_at(global_transform.origin + velocity)
	hasSeen = false
	nav_agent.target_position = randomPos
	if(abs(randomPos.x - global_position.x) <= 5 and abs(randomPos.z - global_position.z) <= 5) or wanderTimer <=0:
		randomPos = Vector3(randf_range(player.global_position.x-40, player.global_position.x+40), position.y,
		 randf_range(player.global_position.z-40, player.global_position.z+40))
		wanderTimer = 60.0
'
