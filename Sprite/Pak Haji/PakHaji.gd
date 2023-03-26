extends CharacterBody2D


@export var SPEED = 100
@export var JUMP_VELOCITY = -200
@export var gravity = 500
#@export var smoothing = 10
@onready var animsprite = $AnimatedSprite2D

var isfalling = false

func _ready():
	pass
	
	
func _physics_process(delta):
	
	#instead of playing animation every time the checker detects, you may try to make a state variable
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if velocity.y <= 0 :
			print("jumping")
		if velocity.y > 0 :
			animsprite.play("fall")
			print("falling")
	else :
		if (velocity.x == 0):
			animsprite.play("idle")
			print("idling")
		else :
			animsprite.speed_scale = abs(velocity.x) * 0.01
			animsprite.play("walk")
			print("walking")
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(animsprite,"scale",Vector2(1,0.7),0.1)
		tween.tween_property(animsprite,"scale",Vector2(1,1.2),0.2)
		tween.tween_property(animsprite,"scale",Vector2(1,1),0.2)
		animsprite.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
		
		if (velocity.x <0):
			animsprite.flip_h = true
		elif (velocity.x >0):
			animsprite.flip_h = false
		
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

