extends PanelContainer

var start_time := Time.get_ticks_msec()

@onready var _time_label: Label = %TimeLabel


func open() -> void:
	visible = true
	get_tree().paused = true

	var end_time := Time.get_ticks_msec()
	var total_time_msec := end_time - start_time
	var total_time_s := snappedf(total_time_msec / 1000.0, 0.1)
	_time_label.text = "Time: " + str(total_time_s) + "s"


func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene() # Replace with function body.
	

func _on_button_2_pressed() -> void:
	get_tree().quit() # Replace with function body.
