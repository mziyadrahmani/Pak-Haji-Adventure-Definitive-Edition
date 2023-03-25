extends Camera2D

func _process(_delta):
	# Get the position of the player node
	var player_pos = get_node("../Player").position
	
	# Set the camera position to the player position
	position = player_pos
