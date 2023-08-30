extends KinematicBody2D


onready var Animations = $AnimatedSprite

export var velocity = Vector2(0,0)
export var speed = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		
		velocity.x = speed
		Animations.play("Walk")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	else:
		velocity.x = 0
	move_and_slide(velocity)
#	pass
