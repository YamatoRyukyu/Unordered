extends CharacterBody2D

var player
var health

func _ready() -> void:
	player = get_node("/root/Game/Player")
	health =3

func _physics_process(delta: float) -> void:
	var speed = 150.0
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

	# if some input is existing
	if direction != Vector2.ZERO:
		rotation = direction.angle()

func take_damage(damage: float):
	health -=damage
	
	if health <=0:
		queue_free()
