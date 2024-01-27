extends Node2D

var _mouse_position: Vector2

func _ready() -> void:
	pass # Replace with function body.

func _process(delta) -> void:
	handle_input(delta)
	
	_mouse_position = get_viewport().get_mouse_position()
	
func _physics_process(delta):
	if Input.is_action_pressed("zoom_in"): # up
		# 36 is a zoom level where we have recuresed into a smaller scene
		var m = ($Camera2D.zoom / 36) * 30
		$Camera2D.zoom += Vector2.ONE * delta * m
		
func handle_input(delta: float) -> void:
	if Input.is_action_just_pressed("debug_print"): # p
		debug_print()
		
func debug_print() -> void:
	print("zoom = %v" % $Camera2D.zoom)
	#get_tree().change_scene_to_file("res://eyeball.tscn")
	
	print("mouse pos = %v" % _mouse_position)
	
	
	
