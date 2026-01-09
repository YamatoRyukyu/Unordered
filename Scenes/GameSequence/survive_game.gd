extends Node2D

var time_count: int
var pause_scene: PackedScene

@export_range(0, 4096, 0.001) var spawn_span: float =0.5

func _ready() -> void:
	%spawn_timer.wait_time = spawn_span
	time_count =0
	pause_scene =preload("res://Scenes/GameSequence/pause.tscn")
	_timer_to_watch()

func spawn_mob():
	%PathFollow2D.progress_ratio = randf()
	%MobSpawner.spawn(%PathFollow2D.global_position, %Player.level)
	
	
func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	GameManager.survive_time =time_count
	GameManager.load_game_over_scene()

func _on_player_exp_update(current:float, next:float, level:float) -> void:
	%ExpBar.max_value = next
	%ExpBar.value = current
	%LevelLabel.text = str(int(level))


func _on_play_timer_timeout() -> void:
	time_count +=1
	_timer_to_watch()
	
func _timer_to_watch():
	var minute = time_count/60
	var second = time_count%60
	%TimerLabel.text = str(minute).pad_zeros(2) + ":" + str(second).pad_zeros(2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused =true
		var pause_instance =pause_scene.instantiate()
		add_child(pause_instance)
