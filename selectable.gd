extends Node2D

var _is_mouseover: bool = false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta) -> void:
	pass
	
func _on_mouse_entered() -> void:
	_is_mouseover = true
	queue_redraw()

func _on_mouse_exited() -> void:
	_is_mouseover = false
	queue_redraw()
	
func _draw() -> void:
	draw_mouseover()
	
func draw_mouseover() -> void:
	if _is_mouseover:
		var size = Vector2(60, 60)
		var pos = Vector2.ZERO - size / 2
		var rect = Rect2(pos, size)
		var color = Color(1, 1, 1, 0.3)
		draw_rect(rect, color, true, 10)

	

