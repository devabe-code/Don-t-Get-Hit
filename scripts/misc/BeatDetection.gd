extends AudioStreamPlayer

# BPM of the song (you can set this manually or calculate it using an external tool)
var bpm: float = 100.0
var tween
var obstacle_interval
var obstacle_rate

# Timer for obstacle placement
@export var obstacle_timer: Timer
@export var trap : Node2D
@export var player : CharacterBody2D
@export var inputs : Node2D

func _ready():
	# Calculate the interval between obstacles
	obstacle_interval = 60.0 / bpm  # in seconds
	
	obstacle_rate = obstacle_interval * player.DIFFICULTY/2
	
	# Set the timer interval and start it
	obstacle_timer.start(obstacle_rate)
	# Play the audio
	play()

func _process(delta):
	pass

func check_dir():
	match trap.arrow_dir:
		"arrow_up":
			if Input.is_action_pressed("jump"):
				return true
		"arrow_down":
			if Input.is_action_pressed("roll"):
				return true
		"arrow_left":
			if Input.is_action_pressed("dash_back"):
				return true
		"arrow_right":
			if Input.is_action_pressed("dash_forward"):
				return true
	return false

func play_acc(arrow_scale : float):
	if  ((arrow_scale > .4) and 
		(arrow_scale < .6) and check_dir()):
		print("playing")
		inputs.get_node("AnimationPlayer").play("ok")
	elif ((arrow_scale > .7) and 
		 (arrow_scale < .9) and check_dir()):
		inputs.get_node("AnimationPlayer").play("good")
	elif ((arrow_scale == 1) and check_dir()):
		print("playing")
		inputs.get_node("AnimationPlayer").play("perfect")
	elif  ((arrow_scale > 0) and 
		(arrow_scale <= .3) and check_dir()):
		inputs.get_node("AnimationPlayer").play("bad")


func _on_beat_timer_timeout():
	trap.set_traps()
