extends Node2D

func _ready() -> void:
	var spawn_span = 0.3
	%spawn_timer.wait_time = spawn_span

func spawn_mob():
	var new_mob = preload("res://Scenes/Mobs/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	


func _on_timer_timeout() -> void:
	spawn_mob()
