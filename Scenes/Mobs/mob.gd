extends CharacterBody2D

var knockback_velocity: Vector2 =Vector2.ZERO
@export var friction: float =0.1

var player
var exp_manager
var health
@export var attack: float
@export var damage_disp_time: float =0.5

func _ready() -> void:
	player = get_node("/root/Game/Player")
	exp_manager = get_node("/root/Game/ExpManager")
	health =3
	%DamageLabel.visible =false
	%DamageDisplayTimer.wait_time =damage_disp_time

func _physics_process(delta: float) -> void:
	var speed = 150.0
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	velocity += knockback_velocity
	
	knockback_velocity =knockback_velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()

	# if some input is existing
	if direction != Vector2.ZERO:
		rotation = direction.angle()
		
	if player in %attack_zone.get_overlapping_bodies():
		player.take_damage(attack * delta)

func take_damage(damage: float):
	health -=damage
	%DamageLabel.visible =true
	%DamageLabel.text =str(damage)
	
	%DamageDisplayTimer.start()
	
	if health <=0:
		exp_manager.spawn(global_position, 10)
		queue_free()


func _on_damage_display_timer_timeout() -> void:
	%DamageLabel.visible =false

func apply_knockback(force_vector: Vector2):
	knockback_velocity = force_vector
