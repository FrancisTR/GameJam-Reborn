extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_next_level_2d_entered(body: Node2D) -> void:
	if body.name == "Ghost" :
		Transition.transition_to_scene("res://Scenes/Level2.tscn")
		$Ghost.is_floating = true
