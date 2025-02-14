class_name Player extends CharacterBody2D

@export var speed := 500.0
@export var drag_factor := 10.0
@export var max_health := 100
var health := max_health: set = set_health
@onready var _health_bar: ProgressBar = %HealthBar
@onready var _collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
const dash_speed = 2000
var dashing = false
var can_dash = true
@onready var death_screen: PanelContainer = $"../CanvasLayer/DeathScreen"


func _ready() -> void:
	_health_bar.max_value = max_health
	_health_bar.value = health
	


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$DashTimer.start()
		$DashAgain.start()
	var move_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_velocity := speed * move_direction
	var steering := desired_velocity - velocity
	if dashing:
		velocity = move_direction * dash_speed
	else:
		velocity += steering * drag_factor * delta
	velocity += steering * drag_factor * delta
	move_and_slide()

func set_health(new_health: int) -> void:
	var previous_health := health
	health = clampi(new_health, 0, max_health)
	_health_bar.value = health
	if health == 0:
		die()
		
		
func die() -> void:
	death_screen.visible = true
	get_tree().paused = true
	if death_screen.visible == true:
		queue_free()


func _on_gong_body_entered(body: Node2D) -> void:
	audio_stream_player.play()


func _on_dash_timer_timeout() -> void:
	dashing = false


func _on_dash_again_timeout() -> void:
	can_dash = true
