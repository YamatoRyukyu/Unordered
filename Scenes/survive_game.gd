extends Node2D

var time_count: int

func _ready() -> void:
	var spawn_span = 0.3
	%spawn_timer.wait_time = spawn_span
	time_count =0
	_timer_to_watch()

func spawn_mob():
	var new_mob = preload("res://Scenes/Mobs/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	


func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true


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
