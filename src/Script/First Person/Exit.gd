extends Area3D
class_name Exit

@export var title : String
signal end_scene(title : String)


func _on_body_entered(body):
	if body is CharacterBody3D:
		end_scene.emit(title)
		
