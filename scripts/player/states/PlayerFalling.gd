extends State
class_name PlayerFalling

@export var landed : bool
@export var player : CharacterBody2D

func Enter():
	player.curr_state = "Falling"
	landed = false
	player.animator.play("falling")

func Update(_delta: float):
	if (player.is_on_floor()):
		player.can_dash = true
		player.can_jump = true
		state_transition.emit(self, "PlayerRun")
	if (Input.is_action_pressed("roll") and player.velocity.y > 50):
		downward_dash()

func downward_dash():
	player.animator.play("dash_down")
	player.velocity.y += 50

