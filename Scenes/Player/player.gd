extends CharacterBody2D

@export var action_resources: Array[Resource]
var action_index
var action_len

func _ready() -> void:
	$ActionTimer.wait_time = 1.0
	action_index =0
	action_len =1
	

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	var speed = 600.0
	velocity = direction * speed
	move_and_slide()

	# if some input is existing
	if direction != Vector2.ZERO:
		rotation = direction.angle()

func call_action():
	$action_area.generate_action(action_resources[action_index])
	action_index = (action_index +1)%action_len
	
func _on_action_timer_timeout() -> void:
	call_action()
