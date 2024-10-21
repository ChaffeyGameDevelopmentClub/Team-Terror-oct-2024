extends Control  # Ensure it matches the node type you're using (Control)

# Runs every frame to check for the pause key press
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause_menu()

# Toggles the pause menu visibility and pauses the game
func toggle_pause_menu():
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused  # Toggle the paused state
	visible = !visible  # Toggle the menu's visibility

# Resume button callback function
func _on_Resume_pressed():
	get_tree().paused = false
	visible = false  # Hide the menu

# Quit button callback function
func _on_Quit_pressed():
	get_tree().quit()  # Quit the game

func _on_Options_pressed():
	$OptionsMenu.visible = true  # Make the options menu visible
	visible = false  # Hide the pause menu
 
