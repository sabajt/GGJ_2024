extends Node2D

@export var id: String

var _is_mouseover: bool = false

signal item_selected(id: String)

func _ready() -> void:
	pass # Replace with function body.

func _process(delta) -> void:
	_handle_input()
	
func _handle_input():
	if _is_mouseover and Input.is_action_just_pressed("select"):
		item_selected.emit(id)
	
func _on_mouse_entered() -> void:
	_is_mouseover = true
	queue_redraw()

func _on_mouse_exited() -> void:
	_is_mouseover = false
	queue_redraw()
	
func _draw() -> void:
	_draw_mouseover()
	
func _draw_mouseover() -> void:
	if _is_mouseover:
		var size = Vector2(60, 60)
		var pos = Vector2.ZERO - size / 2
		var rect = Rect2(pos, size)
		var color = Color(1, 1, 1, 0.3)
		draw_rect(rect, color, true, 10)

	

