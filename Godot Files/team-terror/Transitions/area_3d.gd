extends Area3D


func _on_body_entered(body: Node3D) -> void:
		if body.name=="Player":
			SceneTransition.scene_transition_cloud("res://Scenes/Tilemap testing.tscn")
