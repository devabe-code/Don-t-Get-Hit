extends State
class_name PlayerRoll

@export var done_roll : bool
@export var player : CharacterBody2D

func Enter():
	player.curr_state = "Rolling"
	done_roll = false
	player.is_rolling = true
	player.hitbox.monitoring = false
	player.animator.play("roll")

func Update(_delta):
	if (done_roll):
		player.hitbox.monitoring = true
		player.is_rolling = false
		state_transition.emit(self, "PlayerRun")
