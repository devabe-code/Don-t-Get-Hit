extends State
class_name PlayerRoll

@export var done_roll : bool
@export var player : CharacterBody2D

func Enter():
	print("Rolling")
	done_roll = false
	player.is_rolling = true
	player.can_be_hit = false
	player.animator.play("roll")

func Update(_delta):
	if (done_roll):
		player.can_be_hit = true
		player.is_rolling = false
		state_transition.emit(self, "PlayerRun")
