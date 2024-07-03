extends CharacterBody2D
class_name PlayerMain

@onready var fsm = $StateMachine as StateMachine

@export var animator : AnimationPlayer
@export var dash_max := int(400)
@export var speed_timer : Timer
@export var hitbox : Area2D
@export var trap_col : Area2D

var DIFFICULTY = int(4)
var MOVE_SPEED = int(150)
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
var input_dir : float

var player_to_screen : int
var dashspeed := int(200)
var is_rolling := bool(false)
var can_dash := bool(false)
var can_jump := bool(true)
var curr_state : String
var anim_trap : Area2D

@export var label : Label

func _ready():
	speed_timer.start(DIFFICULTY)

func _process(delta):
	player_to_screen = get_global_transform_with_canvas().get_origin().x
	velocity.x = MOVE_SPEED + dashspeed
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	move_and_slide()
	LessenDash(delta)
	
	input_dir = Input.get_axis("dash_back","dash_forward")
	if (Input.get_axis("dash_back","dash_forward") && can_dash && !is_rolling):
		start_dash()

func start_dash():
	var curr_anim = animator.current_animation
	
	if (input_dir > 0):
		animator.play("dash_forward")
		dashspeed = dash_max
	else:
		animator.play("dash_back")
		dashspeed = -dash_max
	
	if (!animator.is_playing()):
		animator.play(curr_anim)
	
	can_dash = false

func LessenDash(delta):
	var multiplier = 8.0
	var timemultiplier = 8.1
	
	dashspeed -= (dashspeed * multiplier * delta) + (delta * timemultiplier)
	
	if (input_dir > 0):
		if (dashspeed <= 0  and player_to_screen < get_viewport_rect().size.x/1.5):
			can_dash = true
	elif (input_dir < 0):
		if (dashspeed >= 0):
			can_dash = true

func _on_timer_timeout():
	if MOVE_SPEED < 300:
		MOVE_SPEED += 5
		trap_col.scale.x += .05

func _on_hitbox_area_entered(area):
	print("dead")
	#fsm.force_change_state("PlayerDeath")

func _on_activation_area_area_entered(area):
	anim_trap = area
