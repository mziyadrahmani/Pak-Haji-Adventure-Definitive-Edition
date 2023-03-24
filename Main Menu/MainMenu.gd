extends Control
@onready var checksave = Global.get("isgamesaved")

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect2.visible = true
	$AnimationPlayer.play("Transition/DipIn")
	await get_tree().create_timer(3).timeout
	$ColorRect2.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_button_button_up():
	$ColorRect2.visible = true
	$"AnimationPlayer".play("Transition/DipOut")
	await get_tree().create_timer(3).timeout
	get_tree().quit()


func _on_play_button_button_up():
	if checksave == true :
		$ColorRect2.visible = true
		$"AnimationPlayer".play("Transition/DipOut")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://Main Menu/LoadGame.tscn")
	else : 
		pass
