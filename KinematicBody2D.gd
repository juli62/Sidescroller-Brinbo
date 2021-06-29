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
var target = Vector2()
var c_down = 0
onready var tween = get_node("../Sprite/Tween")
onready var pos = get_node(".")
# Called when the node enters the scene tree for the first time.
func _input(event):
	if Input.is_action_just_pressed("P"):
		$"../Camera2D/TextureRect".visible = !$"../Camera2D/TextureRect".visible
		   # Mouse in viewport coordinates.
	

	
func _physics_process(delta):
	velocity.y += gravity
	print(c_down)
	var friction = false
	if Input.is_action_just_pressed("click") and $"../Sprite/TextureProgress".value > 25:
		target = get_global_mouse_position()
		velocity = position.direction_to(target) * 550
		c_down = c_down + 1
		$"../Sprite/TextureProgress".value = $"../Sprite/TextureProgress".value - 25
		$Timer.start()
			
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
		velocity.y = lerp(velocity.y, 0 , 0.5)
		#walljumps depending on left or right 		
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("left"):
			$AnimatedSprite.play("slide")
			velocity.y = jump_h 
			velocity.x = max_speed
		if Input.is_action_just_pressed("jump") and Input.is_action_pressed("right"):
			$AnimatedSprite.play("slide")
			velocity.y = jump_h 
			velocity.x = -max_speed
		
	velocity = move_and_slide(velocity, up)
	


func _on_Timer_timeout():
	if $"../Sprite/TextureProgress".value <= 25:
		
		tween.interpolate_property($"../Sprite/TextureProgress", "value",
			0, 100, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
