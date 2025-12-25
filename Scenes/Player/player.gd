extends CharacterBody2D

signal health_depleted
signal call_levelup_ui
signal exp_update

@export var action_resources: Array[Resource]
@export var health: float
var action_index
var action_len

var level:int
var current_exp:int
var exp_to_next_level:int

var buff_multiplier ={
	"orb_magnet":1.0
}

func _ready() -> void:
	$ActionTimer.wait_time = 1.0
	action_index =0
	action_len = action_resources.size()
	
	level =1
	current_exp =0
	exp_to_next_level =10
	_exp_update_signal()
	
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

func take_damage(damage: float):
	health -= damage
	if health <= 0.0:
		health_depleted.emit()
		
func level_up():
	get_tree().paused = true
	current_exp =0
	level +=1
	exp_to_next_level =level *10	
	
	_exp_update_signal()
	call_levelup_ui.emit()

func get_exp():
	current_exp +=1
	_exp_update_signal()
	
	if exp_to_next_level <= current_exp:
		level_up()

func _exp_update_signal():
	exp_update.emit(current_exp, exp_to_next_level, level)

func upgrade(upgrade_type: String, upgrade_value:float):
	buff_multiplier[upgrade_type] *= upgrade_value
	
	$AttractOrbArea/CollisionShape2D.scale *= buff_multiplier["orb_magnet"]

func _on_level_upui_upgrade_chosen(upgrade_target:String,upgrade_type: String, upgrade_value: float) -> void:
	match upgrade_target:
		"action":
			$action_area.generate_upgrade(upgrade_type, upgrade_value)
		"player":
			upgrade(upgrade_type, upgrade_value)
