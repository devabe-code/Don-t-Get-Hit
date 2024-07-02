extends State
class_name PlayerRun

@export var player : CharacterBody2D

func Enter():
	player.curr_state = "Running"
	player.animator.play("run")

func Update(_delta: float):
	if (Input.is_action_pressed("jump") and player.can_jump):
		state_transition.emit(self, "PlayerJumping")
	
	if (Input.is_action_just_pressed("roll")):
		state_transition.emit(self, "PlayerRoll")
	
	if (player.is_on_floor() and !player.animator.is_playing()):
		player.animator.play("run")
	
