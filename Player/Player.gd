extends CharacterBody2D

@export var pointer = position
@export var speed : int
@export var draw_range: int

var target
var distance

func _ready():
	target = position

#func in_range(pos):
	#if (pos-position).length() <= draw_range:
		#print(true)
		#return true

func _input(event):
	if event.is_action_pressed("right_click"):
		target = get_global_mouse_position()
	#if event.is_action_pressed("left_click"):
		#in_range(get_global_mouse_position())

func _physics_process(delta):
	pointer = get_global_mouse_position()
	look_at(pointer)
	
	var target_velocity = position.direction_to(target) * speed * delta
	velocity = target_velocity if position.distance_to(target) > 1 else Vector2()
	
	if move_and_slide():
		target = position


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
