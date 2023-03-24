extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("DipIn")
	await get_tree().create_timer(3).timeout
	$AnimationPlayer.play("DipOut")
	await get_tree().create_timer(3.1).timeout
	get_tree().change_scene_to_file("res://Main Menu/MainMenu.tscn")
	


