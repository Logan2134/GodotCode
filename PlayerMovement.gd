extends CharacterBody2D

## variables that handle the speed of the player
const max_speed = 400 	
const acel = 1500 	
const friction = 600	

## variables handeling the jumpforce/speed of the player
var input = Vector2.ZERO
var gravity = 20
var jumpSpeed = -250
var current_dir = "none"

func _physics_process(delta):
	player_movement(delta)
	
## handles the user input
func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	return input.normalized()

## handles the player movement
func player_movement(delta):

	input = get_input()
	
	## declares the velocity
	velocity.y = velocity.y + gravity

	## handles the jump of the player ensuring that the player jumps in the right direction
	if int(Input.is_action_pressed("ui_up")):
		velocity.y = jumpSpeed
		
	## handles the velocity of the player
	if input == Vector2.ZERO:
		if velocity.length() > (friction*delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity +=(input * acel * delta)
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()