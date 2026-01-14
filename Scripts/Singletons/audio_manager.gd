extends Node

const BGM_BUS_NAME ="BGM"
const SFX_BUS_NAME ="SFX"

var master_bus_index =0
@onready var bgm_bus_index = AudioServer.get_bus_index(BGM_BUS_NAME)
@onready var sfx_bus_index = AudioServer.get_bus_index(SFX_BUS_NAME)

var bgm_player: AudioStreamPlayer

func _ready() -> void:
	if bgm_bus_index ==-1:
		push_error("Audio Bus '%s' not found" % BGM_BUS_NAME)
	if sfx_bus_index ==-1:
		push_error("Audio Bus '%s' not found" %SFX_BUS_NAME)
		
	AudioServer.set_bus_volume_linear(master_bus_index, 1)
	set_bgm_volume(0.1)
	set_sfx_volume(0.1)
		
func play_bgm(stream: AudioStream, fade_in_duration: float =5.0):
	if not bgm_player:
		bgm_player = AudioStreamPlayer.new()
		bgm_player.bus =BGM_BUS_NAME
		add_child(bgm_player)
	
	bgm_player.stream =stream
	bgm_player.volume_db = -80.0
	bgm_player.play()
	
	var tween = create_tween()
	tween.tween_property(bgm_player, "volume_db", 0.0, fade_in_duration)
	
func stop_bgm():
	bgm_player.queue_free()
	
func play_sfx(stream: AudioStream, position:Vector2 =Vector2.ZERO):
	var player: Node
	if position == Vector2.ZERO:
		player = AudioStreamPlayer.new()
	else :
		player = AudioStreamPlayer2D.new()
		player.global_position =position
	
	player.stream =stream
	player.bus =SFX_BUS_NAME
	add_child(player)
	player.play()
	player.finished.connect(func(): player.queue_free())

func set_bgm_volume(linear_volume: float):
	if bgm_bus_index ==-1:
		return
	AudioServer.set_bus_volume_db(bgm_bus_index, linear_to_db(clampf(linear_volume, 0.0, 1.0)))

func set_sfx_volume(linear_volume: float):
	if sfx_bus_index == -1:
		return
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(clampf(linear_volume, 0.0, 1.0)))

func set_master_volume(linear_volume: float):
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(clampf(linear_volume, 0.0, 1.0)))

func get_master_volume_linear() -> float:
	return AudioServer.get_bus_volume_linear(master_bus_index)

func get_bgm_volume_linear() -> float:
	if bgm_bus_index ==-1:
		return -1
	return AudioServer.get_bus_volume_linear(bgm_bus_index)

func get_sfx_volume_linear() -> float:
	if sfx_bus_index ==-1:
		return -1
	return AudioServer.get_bus_volume_linear(sfx_bus_index)
