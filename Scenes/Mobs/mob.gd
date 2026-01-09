extends CharacterBody2D

var knockback_velocity: Vector2 =Vector2.ZERO
@export var friction: float =0.1
@export var damage_label_scene: PackedScene

var player
var exp_manager
var health
var label_displayer :Node
@export var attack: float

func _ready() -> void:
	player = get_node("/root/Game/Player")
	exp_manager = get_node("/root/Game/ExpManager")
	damage_label_scene =preload("res://Scenes/DamageLabel/damage_label.tscn")
	label_displayer =get_node("/root/Game")
	
	health =3

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
	_damage_timer_setting(damage)

	if health <=0:
		exp_manager.spawn(global_position, 10)
		queue_free()


func apply_knockback(force_vector: Vector2):
	knockback_velocity = force_vector

func _damage_timer_setting(damage:float):
	var damage_label_instance: Label =damage_label_scene.instantiate()
	add_child(damage_label_instance)	
	damage_label_instance.set_label_text(str(int(damage)))
	damage_label_instance.global_position =Vector2(
		global_position.x -damage_label_instance.size.x/2,
		global_position.y -damage_label_instance.size.y/2
	)
	damage_label_instance.reparent(label_displayer)	
