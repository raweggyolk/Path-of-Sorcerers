extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var _teleporter: Area2D = %Teleporter
@onready var end_screen: PanelContainer = $Teleporter/CanvasLayer/EndScreen


func _ready() -> void:
	audio_stream_player_2d.play()
	_teleporter.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			end_screen.open()
	)
