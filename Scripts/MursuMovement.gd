extends KinematicBody2D


onready var Animations = $AnimatedSprite

export var velocity = Vector2(0,0)
export var speed = 400
export var jump_force = 500


export var gravity = 800

var active = true

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += delta * gravity
		if velocity.y > 1000:
			velocity.y = 1000
	var direction = 0
	
	if active:		
		if Input.is_action_just_pressed("ui_select") && is_on_floor():
			jump(jump_force)
		
		direction = Input.get_axis("ui_left","ui_right")
		if direction != 0:
			Animations.flip_h = (direction == -1)
		velocity.x = direction * speed
	
	velocity = move_and_slide(velocity, Vector2.UP)
	update_animations(direction)



func update_animations(direction):

	if is_on_floor():
		if direction == 0:
			Animations.play("Default")
		else:
			Animations.play("Walk")
	else:
		if velocity.y < 0:
			Animations.play("Jump")
		else:
			#Animations.play("fall")
			return

func jump(force):
	velocity.y = -force
