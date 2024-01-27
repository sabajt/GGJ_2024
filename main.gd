extends Node2D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta) -> void:
	handle_input(delta)
	
func _physics_process(delta):
	if Input.is_action_pressed("zoom_in"): # up
		# 36 is a zoom level where we have recuresed into a smaller scene
		var m = ($Camera2D.zoom / 36) * 30
		$Camera2D.zoom += Vector2.ONE * m * delta
		
func handle_input(delta: float) -> void:
	if Input.is_action_just_pressed("debug_print"): # p
		debug_print()
		
func debug_print() -> void:
	print("zoom = %v" % $Camera2D.zoom)
	
