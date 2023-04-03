extends Node2D
var isgamesaved = false 

var playermaxhealth = 100
var playerhealth = playermaxhealth
var isdead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass







func _on_health_bar_playerdead():
	if isdead == false:
		print("dead")
		isdead = true
