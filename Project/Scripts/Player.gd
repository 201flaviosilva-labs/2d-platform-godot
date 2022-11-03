extends KinematicBody2D

export var SPEED: int = 200
export var JUMP_FORCE: int = 600
export var GRAVITY: int = 800

var velocity: Vector2 = Vector2.ZERO

onready var SPRITE : AnimatedSprite = $AnimatedSprite

func _process(delta: float) -> void:
	# Movimentation
	if Input.is_action_pressed("Left"): velocity.x = -SPEED
	elif Input.is_action_pressed("Right"): velocity.x = SPEED
	else: velocity.x = 0
	
	# Gravity and jump
	velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("Jump") and is_on_floor(): velocity.y -= JUMP_FORCE
	
	# Flip and animations
	if abs(velocity.x) > 0:
		if is_on_floor(): SPRITE.play("Run")
		SPRITE.flip_h = velocity.x < 0
	elif is_on_floor(): SPRITE.play("Idle") # It's in the ground and not moving
	
	if not is_on_floor(): SPRITE.play("Jump")

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2.UP)

