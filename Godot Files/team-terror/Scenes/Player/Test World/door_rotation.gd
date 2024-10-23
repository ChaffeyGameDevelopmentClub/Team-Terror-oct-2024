extends Node3D

var opened = false
@export var left_hinge = Area3D
@export var right_hinge = Area3D
func _ready() -> void:
	$MeshInstance3D2/LeftSideHinge.connect("leftopens", open_left)
	$MeshInstance3D2/RightSideHinge.connect("rightopens", open_right)
	pass
func open_left():
	if opened == false:
		rotation.y = lerp(0.0,85.0,.1)
		opened = true
		pass
	pass
func open_right():
	if opened ==false:
		rotation.y = lerp(0.0,-85.0,.1)
		opened = true
		pass
	pass
