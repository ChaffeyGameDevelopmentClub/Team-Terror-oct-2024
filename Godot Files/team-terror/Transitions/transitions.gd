extends CanvasLayer
@export var Open: AudioStreamPlayer
@export var Close: AudioStreamPlayer

func open_door_to(target_scene: String):
	$AnimationPlayer.play("fadetoblack")
	Open.play()
	await($AnimationPlayer.animation_finished)
	get_tree().change_scene_to_file(target_scene)
	$AnimationPlayer.play("doorapproaching")
	await($AnimationPlayer.animation_finished)
	Close.play()
	$AnimationPlayer.play_backwards("fadetoblack")
	pass

func scene_reset():
	$AnimationPlayer.play("RESET")
