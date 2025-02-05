@tool
class_name Pickup extends Area2D

@export var item: Item = null: set = set_item
@onready var _sprite_2d: Sprite2D = %Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = %AudioStreamPlayer2D

func _ready() -> void:
	set_item(item)
	body_entered.connect(func (body: Node2D) -> void:
		if body is Player:
			item.use(body)
			audio_stream_player_2d.play()
			queue_free()
	)
	
func set_item(value: Item) -> void:
	item = value
	if _sprite_2d != null:
		_sprite_2d.texture = item.texture
	if audio_stream_player_2d != null:
		audio_stream_player_2d.stream = item.sound_on_pickup
		
