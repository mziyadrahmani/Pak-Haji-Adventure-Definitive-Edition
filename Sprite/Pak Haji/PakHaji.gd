extends CharacterBody2D


@export var SPEED = 100
@export var JUMP_VELOCITY = -200
@export var gravity = 500
#@export var smoothing = 10
@onready var animsprite = $AnimatedSprite2D
@onready var tilemap = get_node("../TileMap")
#@onready var crntcoor = animsprite.get_global_position()
var isfalling = false
var isclimbing = false #false = kanan
#var trunktile = terrainset
func _ready():
	pass
	
	
func _physics_process(delta):
	#print(crntcoor)
	if (velocity.x <0):
		animsprite.flip_h = true
		
	elif (velocity.x >0):
		animsprite.flip_h = false
	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var object = collision.get_collider ( )
		#print(object)
		if object.name == "Climbable" and object.is_in_group("climbable"):
			isclimbing = true
			climbing()
		else :
			isclimbing = false	
			
	if not is_on_floor() and not is_on_wall():
		velocity.y += gravity * delta
		
		if (velocity.y < 0):
			animsprite.play("jump")
		if (velocity.y > 0):
			animsprite.play("fall")
	else :
		if (velocity.x == 0) and not isclimbing:
			animsprite.play("idle")
		elif (velocity.x != 0) and not isclimbing: 
			animsprite.speed_scale = abs(velocity.x) * 0.01
			animsprite.play("walk")
			
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(animsprite,"scale",Vector2(1,0.7),0.1)
		tween.tween_property(animsprite,"scale",Vector2(1,1.2),0.2)
		tween.tween_property(animsprite,"scale",Vector2(1,1),0.2)
		
	
	var direction = Input.get_axis("left", "right")
	if direction and not isclimbing:
		velocity.x = direction * SPEED

	elif direction and isclimbing :	
		velocity.x = direction * SPEED
		velocity.y += gravity * delta
		if not is_on_wall():
			isclimbing = false 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func climbing():
	if isclimbing == true and is_on_wall() :
		#print("climb")
		var updowndir = Input.get_axis("jump", "down")
		if updowndir :
			velocity.y = updowndir * SPEED
			animsprite.speed_scale = abs(velocity.y) * 0.01
			animsprite.play("climb")
			
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			animsprite.play("climbidle")
			#print("isnotclimbing")


