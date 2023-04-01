extends CharacterBody2D


@export var SPEED = 100
@export var JUMP_VELOCITY = -200
@export var gravity = 500
@onready var animsprite = $AnimatedSprite2D
#@onready var tilemap = get_node("../TileMap")

var health = Global.playerhealth
var isclimbing = false 
var isdead = false
var has_called_player_dead = false
func _ready():
	print(health)
	
	
	
func _physics_process(delta):
	if health <= 0 and not isdead :
		isdead = true
		Global._player_dead()
	enemychecker()
	velocity.y += gravity * delta
	


	if (velocity.x <0):
		animsprite.flip_h = true
		
	elif (velocity.x >0):
		animsprite.flip_h = false

	if is_on_wall() :
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var object = collision.get_collider ( )
			#print(object)
			if object.name == "Climbable" and object.is_in_group("climbable"):
				isclimbing = true
				climbing()
			else :
				isclimbing = false
	if not is_on_floor() and not isclimbing:
		#velocity.y += gravity * delta
		
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
		#velocity.y += gravity * delta
		if not is_on_wall():
			isclimbing = false 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func climbing():
	if isclimbing == true  :
		#print("climb")
		var updowndir = Input.get_axis("jump", "down")
		if updowndir :
			velocity.y = updowndir * SPEED
			animsprite.speed_scale = abs(velocity.y) * 0.01
			animsprite.play("climb")
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			animsprite.play("climbidle")
	
		
#handle damage
func enemychecker():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var object = collision.get_collider ( )
		if object.is_in_group("can_damage"):
			var timer = object.dmgcd
			var oncd 
			#print(timer.get_time_left())
			if timer.get_time_left() > 0 :
				oncd = true
			else :
				oncd = false
			if not oncd:
				health -= object.dmg
				timer.start()
				if health < 0 :
					health = 0
				else:
					print(health)
			
			
			
			
	
