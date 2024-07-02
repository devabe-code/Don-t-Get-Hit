extends State
class_name PlayerJump

@export var has_jumped : bool
@export var player : CharacterBody2D
@export var JUMP_VELOCITY := -430

func Enter():
	player.curr_state = "Jumping"
	has_jumped = false

func Update(_delta: float):
	if (player.velocity.y > 0):
		player.can_dash = false
		state_transition.emit(self, "PlayerFalling")
	elif (player.is_on_floor() and player.can_jump and Input.is_action_pressed("jump")):
		jump()

func jump():
	player.animator.play("jumping")
	player.velocity.y = JUMP_VELOCITY
	has_jumped = true
