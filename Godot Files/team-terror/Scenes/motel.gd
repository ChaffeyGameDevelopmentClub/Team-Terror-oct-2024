extends Node3D

@export var funny : AudioStreamPlayer
var isplaying = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if isplaying == false:
		isplaying = true
		funny.play()
		await(funny.finished)
		isplaying = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
