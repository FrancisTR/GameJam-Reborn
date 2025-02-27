extends Control
@onready var start = $Start
@onready var exit = $Exit

func _ready():
	start.button_down.connect(on_start_pressed)
	exit.button_down.connect(on_exit_pressed)
		
	

func on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
	
func on_exit_pressed():
	get_tree().quit()
