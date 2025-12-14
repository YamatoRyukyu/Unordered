extends CharacterBody2D

var player
var exp_manager
var health
@export var attack: float

func _ready() -> void:
	player = get_node("/root/Game/Player")
	exp_manager = get_node("/root/Game/ExpManager")
	health =3

func _physics_process(delta: float) -> void:
	var speed = 150.0
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

	# if some input is existing
	if direction != Vector2.ZERO:
		rotation = direction.angle()
		
	if player in %attack_zone.get_overlapping_bodies():
		player.take_damage(attack * delta)

func take_damage(damage: float):
	health -=damage
	
	if health <=0:
		exp_manager.spawn(global_position)
		queue_free()
