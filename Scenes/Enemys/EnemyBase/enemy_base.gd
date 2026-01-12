class_name EnemyBase
extends CharacterBody2D

@export var base_max_health: float =1.0
@export var base_power: float =5.0
@export var speed: float =150.0
@export var fricion: float =0.1
@export var xp_amount: int =1

@export var unlock_action_name: String =""
@onready var damage_se: AudioStream =preload("res://Audios/SE/EnemyDamage/maou_se_sound16.mp3")

var health: float
var knockback_velocity: Vector2 =Vector2.ZERO
var player: CharacterBody2D
var exp_manager: Node
var power: float

@onready var action_area: Node2D =$action_area
@onready var damage_label_scene: PackedScene =preload("res://Scenes/DamageLabel/damage_label.tscn")
var label_displayer: Node

func _ready() -> void:
	player =get_tree().get_first_node_in_group("Player")
	label_displayer =get_node("/root/Game")
	
	exp_manager =get_node("/root/Game/ExpManager")
	
	setup_enemy(1)
	_on_ready_setup()

func setup_enemy(level: int) -> void:
	var multiplier = 1.0 + (level -1)*0.1
	health = base_max_health *multiplier
	power = base_power * multiplier

func _on_ready_setup():
	pass
	
func _physics_process(delta: float) -> void:
	if not player:
		return
	
	var move_vec: Vector2 =_calc_movement(delta)
	
	velocity =move_vec *speed
	velocity += knockback_velocity
	knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, fricion)
	
	move_and_slide()
	
	if move_vec != Vector2.ZERO:
		rotation =move_vec.angle()
	
	_process_attack(delta)	
	
func _calc_movement(delta: float) -> Vector2:
	return Vector2.ZERO

func _process_attack(delta: float) -> void:
	pass
	
func unlock_action() -> void:
	GameManager.unlock_action(unlock_action_name)
	
func take_damage(damage: float) ->void:
	health -= damage
	AudioManager.play_sfx(damage_se, global_position)
	_damage_timer_setting(damage)
	
	if health <= 0:
		die()

func die() ->void:
	unlock_action()
	if exp_manager:
		exp_manager.spawn(global_position, xp_amount)
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
