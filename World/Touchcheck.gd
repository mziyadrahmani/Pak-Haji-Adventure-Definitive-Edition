extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		#print("Jump")
		pass
	elif Input.is_action_just_pressed("down"):
		#print("Down")
		pass
func _on_touch_screen_button_pressed():
	#print("Left")
	pass

func _on_touch_screen_button_2_pressed():
	#print("Right")
	pass

func _on_touch_screen_button_3_pressed():
	pass


func _on_touch_screen_button_4_pressed():
	pass
