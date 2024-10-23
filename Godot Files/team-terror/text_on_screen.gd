extends CanvasLayer

@export var text_play : AnimationPlayer
func Get_Key_Area_1():
	text_play.play("key_text")
	await(text_play.animation_finished)
	text_play.play("key_fade_out")
