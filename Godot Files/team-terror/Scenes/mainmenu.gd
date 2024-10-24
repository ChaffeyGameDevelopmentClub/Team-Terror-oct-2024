extends Control
var options_scene
var sub_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _open_sub_menu(menu : Control):
	sub_menu = menu
	sub_menu.show()
	%BackButton.show()
	%MenuContainer.hide()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/motel.tscn")
# "res://Scenes/movement_testing_scene.tscn"

func _on_options_pressed() -> void:
	pass
	#get_tree().change_scene_to_file("res://Scenes/Ui/menus/options_menu/master_options_menu_with_tabs.tscn")
	#_open_sub_menu("res://Scenes/Ui/menus/options_menu/master_options_menu_with_tabs.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
	
