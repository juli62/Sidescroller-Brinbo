extends Node


const UP = Vector2(0 , -1)
const GRAVITY = 20
const ACCELERATION = 50
const SPEED = 200
const JUMP_HEIGHT = -550

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("right"):
		motion.x += ACCELERATION
	elif Input.is_action_pressed("left"):
		motion.x -= ACCELERATION
	else:
		motion.x = 0		
		
		
	motion = move_and_slide(motion, UP)
	
