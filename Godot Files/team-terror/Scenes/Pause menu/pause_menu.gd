extends Control


func _on_Resume_button_pressed():
	get_tree().paused=false
	hide()
	pass
func _on_Options_button_pressed():
	#go to options
	pass
func _on_Quit_button_pressed():
	get_tree().quit
	pass
