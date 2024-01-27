extends Node2D

class Bubble:
	var timeRemaining = 0.0
	var wordBubble : PackedScene

var timeFactor = 100
var hasEmitted = false
var emitInterval := 500
var emitCountdown := 100.0

var bubbles = []

@onready var _word_bubble = preload("res://word_bubble.tscn")

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	print(emitCountdown)
	emitCountdown -= delta * timeFactor
	if (emitCountdown <= 0):
		emitCountdown = emitInterval
		
		var wb : Node2D = _word_bubble.instantiate()
		add_child(wb)
		var bubble = Bubble.new()
		bubble.wordBubble = wb
		bubble.timeRemaining = 70
		bubbles.push_front(bubble)
	
	for bubble in bubbles:
		bubble.timeRemaining -= delta * timeFactor
		print('bubawub %f' % bubble.timeRemaining)
