extends Area2D

@export var speed := 1000.0

var max_range := 1000.0
var _travelled_distance := 0.0

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
