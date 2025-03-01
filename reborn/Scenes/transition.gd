extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func transition_to_scene(scene):
	transition_to_scene_dark(scene)

func transition_to_scene_dark(scene):
	self.visible = true
	animation_player.play("fade_dark")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene)
	animation_player.play_backwards("fade_dark")
	await animation_player.animation_finished
	self.visible = false

func transition_to_scene_bright(scene):
	self.visible = true
	animation_player.play("fade_bright")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene)
	animation_player.play_backwards("fade_bright")
	await animation_player.animation_finished
	self.visible = false
