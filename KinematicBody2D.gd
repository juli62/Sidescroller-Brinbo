extends KinematicBody2D


# Declare member variables here. Examples:
const up = Vector2(0 , -1)
var velocity = Vector2()
const max_speed = 300
const gravity = 30
const jump_h = -550
const acc = 50
var speed_y = 180
var fric_acc = 10
var fric_max = 150
# Called when the node enters the scene tree for the first time.
func _input(event):
	if Input.is_action_just_pressed("P"):
		$"../Camera2D/TextureRect".visible = !$"../Camera2D/TextureRect".visible
		
func _physics_process(delta):
	velocity.y += gravity
	var friction = false
	if Input.is_action_pressed("left"):
		velocity.x = max(velocity.x-acc, -max_speed)
		$AnimatedSprite.set_flip_h(true)
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("right"):
		$AnimatedSprite.set_flip_h(false)
		velocity.x = min(velocity.x+acc, max_speed)
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("default")
		friction = true
	
	
	if is_on_floor():
		if friction == true:
			velocity.x = lerp(velocity.x, 0, 0.2)
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_h
	
	#Walljump
	if is_on_wall() and Input.is_action_pressed("left") || is_on_wall() and Input.is_action_pressed("right"):
		#Generates Friction when left or right button held
		velocity.y = min(velocity.y+fric_acc, fric_max)	
		#velocity.y = lerp(velocity.y, 0 , 0.5)
		#walljumps depending on left or right 		
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("left"):
			
			velocity.y = jump_h 
			velocity.x = max_speed
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("right"):
			
			velocity.y = jump_h 
			velocity.x = -max_speed
	velocity = move_and_slide(velocity, up)
	
