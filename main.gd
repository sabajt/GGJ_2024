extends Node2D

var _mouse_position: Vector2
var _transition_t: float = 0
var _is_transitioning: bool = false
var _transition_pos: Vector2
var _transition_id: String
var _transition_zoom_scale: float

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	handle_input(delta)
	
	_mouse_position = get_viewport().get_mouse_position()
	
func _physics_process(delta: float):
	if _is_transitioning:
		_process_transition(delta)
		
func _process_transition(delta: float):
	_transition_t += 1
	
	var duration = 60.0 * 3.0
	var t = _transition_t / duration
	var zoom_t = t * t * t * t * t
	var pan_t = min(_transition_t / (duration / 2.0), 1)
	pan_t = -pan_t * (pan_t - 2)
	
	var zoom_to = Vector2(_transition_zoom_scale, _transition_zoom_scale)
	$Camera2D.zoom = Vector2.ONE.lerp(zoom_to, zoom_t)
	$Camera2D.position = Vector2.ZERO.lerp(_transition_pos, pan_t)
	
	if _transition_t == duration:
		_transition_t = 0
		_is_transitioning = false
		_complete_transition()
		
func _complete_transition():
		get_tree().change_scene_to_file(_transition_id)
		
func handle_input(delta: float) -> void:
	if Input.is_action_just_pressed("debug_print"): # p
		debug_print()
		
func debug_print() -> void:
	print("zoom = %v" % $Camera2D.zoom)

	print("mouse pos = %v" % _mouse_position)
	
func _on_item_selected(id: String, center: Vector2, zoom_scale: float):
	_is_transitioning = true
	_transition_pos = center
	_transition_id = id
	_transition_zoom_scale = zoom_scale
	print("item selected %s %v -- zoom scale = %f" % [id, center, zoom_scale])


