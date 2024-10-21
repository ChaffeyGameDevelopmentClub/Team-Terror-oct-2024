extends Area3D


func _on_body_entered(body: Node3D) -> void:
		if body.name=="Player" and Input.is_action_pressed("interaction"):
			SceneTransition.scene_transition_cloud("res://Scenes/Tilemap testing.tscn")
