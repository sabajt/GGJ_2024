extends Node2D

@export var id: String
@export var highlight_size: Vector2
@export var zoom_scale: float
@export var is_back: bool

@onready var _origin = Vector2.ZERO - highlight_size / 2

var _is_mouseover: bool = false
var _highlight_rect
var _highlight_color

signal item_selected(id: String, center: Vector2, zoom_scale: float, is_back: bool)

func _ready() -> void:
	_highlight_rect =  Rect2(_origin, highlight_size)
	_highlight_color = Color(0, 1, 0, 0.4)

func _process(delta) -> void:
	_handle_input()
	
func _handle_input():
	if _is_mouseover and Input.is_action_just_pressed("select"):
		item_selected.emit(id, transform.origin, zoom_scale, is_back)
	
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
		draw_rect(_highlight_rect, _highlight_color, false, 10)

	

