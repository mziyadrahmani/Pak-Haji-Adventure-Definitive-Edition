extends TextureProgressBar
signal playerdead()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_pak_haji_health_changed(new_health):
	value = new_health
	if value <= 0:
		emit_signal("playerdead")
		
	
