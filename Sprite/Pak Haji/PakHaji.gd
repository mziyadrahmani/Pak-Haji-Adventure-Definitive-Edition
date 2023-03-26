extends CharacterBody2D


@export var SPEED = 100
@export var JUMP_VELOCITY = -200
@export var gravity = 400
#@export var smoothing = 10
@onready var animsprite = $AnimatedSprite2D
#@onready var tween = create_tween()
var isfalling = false

func _ready():
	pass
	
	
func _physics_process(delta):
	
	#instead of playing animation every time the checker detects, you may try to make a state variable
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if velocity.y <= 0 :
			
			print("jumping")
		else :
			animsprite.play("fall")
			animsprite.speed_scale = 1
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

