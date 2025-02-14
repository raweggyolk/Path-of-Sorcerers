extends Area2D

@export var speed := 1000.0
@export var hit_sound: AudioStreamPlayer2D = null

var max_range := 1000.0
var _travelled_distance := 0.0
var damage := 0.5

func _ready() -> void:
	body_entered.connect(func (body: Node) -> void:
		if body is Mob:
			body.health -= damage
			print(body.health)
		if body is Mob2:
			body.health -= damage
			print(body.health)
		if body is Mob3:
			body.health -= damage
			print(body.health)
	)
	

func _physics_process(delta: float) -> void:
	var distance := speed * delta
	var motion := transform.x * speed * delta
	position += motion
	_travelled_distance += distance
	
	if _travelled_distance > max_range:
		
		_destroy()
	
	var direction := Vector2.RIGHT.rotated(rotation)
	
func _destroy() -> void:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if hit_sound != null:
		hit_sound.play()
		set_deferred("monitoring", false)
		set_physics_process(false)
		hide()
		hit_sound.finished.connect(queue_free)
	else:
		_destroy()
