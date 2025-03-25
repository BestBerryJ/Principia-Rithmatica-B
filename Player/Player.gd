extends CharacterBody2D

var pointer = position
var target
var speed = 100
var distance = 100
var draw_range = 150

func _ready():
	target = position

func in_range(pos):
	if (pos-position).length() <= draw_range:
		print(true)
		return true

func _input(event):
	if event.is_action_pressed("right_click"):
		target = get_global_mouse_position()
	if event.is_action_pressed("left_click"):
		in_range(get_global_mouse_position())

func _physics_process(delta):
	pointer = get_global_mouse_position()
	look_at(pointer)
		
	velocity = position.direction_to(target) * speed
	
	if position.distance_to(target)> 1:
		set_velocity(velocity)
		move_and_slide()
	if get_slide_collision(0):
		target = position
		velocity = Vector2(0,0)


#func _physics_process(delta):
	#pointer = get_global_mouse_position()
	#look_at(pointer)
		#
	#if position.distance_to(pointer) > distance:
		#target = pointer
	#velocity = position.direction_to(target) * speed
	#
	#if position.distance_to(target)> distance:
		#set_velocity(velocity)
		#move_and_slide()
