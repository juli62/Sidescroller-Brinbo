extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$Timer.start(2)
	
func _on_Timer_timeout():
	$Timer.stop()
	visible = true
	$AnimationPlayer.play("New Anim")
