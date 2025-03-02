class_name Mob3 extends CharacterBody2D

@export var max_speed := 500.0
@export var acceleration := 2500.0
@export var health := 100: set = set_health
var damage := 15

var _player: Player = null

@onready var _detection_area: Area2D = %DetectionArea
@onready var _hit_box: Area2D = %HitBox
@onready var _damage_timer: Timer = %DamageTimer



func _ready() -> void:
	_detection_area.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			_player = body
	)
	
	_detection_area.body_exited.connect(func (body: Node) -> void:
		
		if body is Player:
			_player = null
	)
	_hit_box.body_entered.connect(func (body: Node) -> void:
		if body is Player:
			body.health -= damage
			_damage_timer.start()
	)
	_hit_box.body_exited.connect(func (body: Node) -> void:
		if body is Player:
			_damage_timer.stop()
	)

	_damage_timer.timeout.connect(func () -> void:
		_player.health -= damage
	)

func set_health(new_health: int) -> void:
	health = new_health
	if health <= 0:
		die()
		
func die() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	if _player == null:
		velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)
		
	else:
		var direction := global_position.direction_to(_player.global_position)
		var distance := global_position.distance_to(_player.global_position)
		var speed := max_speed if distance > 120.0 else max_speed * distance / 120.0
		var desired_velocity := direction * speed
		
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)

	move_and_slide()
