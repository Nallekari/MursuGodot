extends KinematicBody2D


onready var Animations = $AnimatedSprite
onready var front_sensor = $FrontSensor
onready var back_sensor = $BackSensor

export var velocity = Vector2(0,0)
export var speed = 400
export var jump_force = 500

export var gravity = 800



var touched_ground = true
var active = true

func _physics_process(delta):
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.y += delta * gravity
	if velocity.y > 1000:
		velocity.y = 1000
	var direction = 0
	
	
	if active:
		movement(direction)
	
	if !touched_ground && is_on_floor():
		touched_ground = true
	
	
		
	

func movement(direction):
	if Input.is_action_pressed("jump") && touched_ground:
		jump(jump_force)
			
	direction = Input.get_axis("move_left","move_right")
	if direction != 0:
		var front_last_position = front_sensor.global_position
		var back_last_position = back_sensor.global_position
		front_sensor.global_position = back_last_position
		back_sensor.global_position = front_last_position
		Animations.flip_h = (direction == -1)
	velocity.x = direction * speed
	update_animations(direction)
	if Input.is_action_pressed("slide"):
		slide()

func slide():
	var space_state = get_world_2d().direct_space_state	
	var front_sensor_feed = space_state.intersect_ray(front_sensor.global_position, front_sensor.global_position + Vector2(0,200), [self], collision_mask)
	var back_sensor_feed = space_state.intersect_ray(back_sensor.global_position, back_sensor.global_position + Vector2(0,200), [self], collision_mask)	
	if  front_sensor_feed && back_sensor_feed:
		#gravity = 8000
		print("sliding")		
		if (front_sensor_feed.position.y - back_sensor_feed.position.y) > 0:			
			velocity = Vector2(-speed, (front_sensor_feed.position.y - back_sensor_feed.position.y)+gravity)
			print(str(speed) + "   " + str((front_sensor_feed.position.y - back_sensor_feed.position.y)+gravity))
		elif (front_sensor_feed.position.y-back_sensor_feed.position.y) < 0 :
			velocity = Vector2(speed, front_sensor_feed.position.y - back_sensor_feed.position.y + gravity)
		#if result1 && result2:
		#	print("frontsensor "+ str(result1.position))
		#	print("backsensor "+ str(result2.position))

		
		
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
	yield(get_tree().create_timer(0.25), "timeout")
	touched_ground = false
