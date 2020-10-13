extends KinematicBody2D

export var move_speed = Vector2(100,0)
export var gravity = Vector2(0,100)
export var jump_speed = Vector2(0,-1000)
var floor_normal = Vector2(0,-1)
var movement_velocity

func _ready():
	movement_velocity = Vector2(0,0)
	
func _physics_process(delta):
	movement_velocity.x = 0
	_move_gravity()
	_move_left()
	_move_right()
	_move_jump()
	_move()
		
func _move_left():
	if Input.is_action_pressed("ui_left"):
		movement_velocity = movement_velocity - move_speed
		$AnimatedSprite.scale.x = -1
		$AnimatedSprite.play("run")
		
func _move_right():
	if Input.is_action_pressed("ui_right"):
		movement_velocity = movement_velocity + move_speed
		if $AnimatedSprite.scale.x == -1:
			$AnimatedSprite.scale.x = 1
		$AnimatedSprite.play("run")
		
func _move_jump():
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		movement_velocity = movement_velocity + jump_speed
		$AnimatedSprite.play("jump")

func _move_gravity():
	if is_on_floor():
		movement_velocity.y = gravity.y
	else:
		movement_velocity = movement_velocity + gravity
		$AnimatedSprite.play("fall")

func _move():
	if movement_velocity.x == 0:
		$AnimatedSprite.play("idle")
	move_and_slide(movement_velocity, floor_normal)


	
