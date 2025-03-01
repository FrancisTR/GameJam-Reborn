extends Node2D

func _ready() -> void:
	$Ghost.velocity.y = -100
	$Ghost.is_floating = true

func _on_next_level_2d_entered(body: Node2D) -> void:
	if body.name == "Ghost" :
		Transition.transition_to_scene_bright("res://Scenes/LevelComplete.tscn")
		$Ghost.is_floating = true


func _on_enter_level_2d_exited(body: Node2D) -> void:
	$Ghost.is_floating = false
