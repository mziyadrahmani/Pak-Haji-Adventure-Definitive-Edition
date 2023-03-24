extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Transition/DipIn")
	await get_tree().create_timer(3).timeout
	$ColorRect2.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
