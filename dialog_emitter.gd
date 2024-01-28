extends Node2D

enum DIALOG_ID {
	JERRY,
	STEVE,
	SAMANTHA
}

const TEXTS_JERRY : Array[String] = [
	"u think u know me",
	"...but u dont.........",
	"if u wanna test me ull have to stand toe 2 toe bub",
	"Come to Brazil :D"
]
const TEXTS_STEVE : Array[String] = [
	"hey it's steve and im really cool",
	"don't like drugs but i like going to school"
]
const TEXTS_SAMANTHA : Array[String] = [
	"samanta"
]

class Bubble:
	var timeRemaining : float = 0.0
	var wordBubble : Node2D

func getTexts (id:DIALOG_ID) -> Array[String]:
	match id:
		DIALOG_ID.JERRY: return TEXTS_JERRY
		DIALOG_ID.STEVE: return TEXTS_STEVE
		DIALOG_ID.SAMANTHA: return TEXTS_SAMANTHA
	return []

const timeFactor : float = 100

const bubbleLifetime : float = 325
const bubbleFadeTime : float = 100

const emitInterval : float = 500

var emitCountdown : float = 100.0
var bubbles : Array[Bubble] = []

@export var dialogId : DIALOG_ID = DIALOG_ID.JERRY
@export var textSizeFactor : float = 1.0

var textIndex : int = 0
var texts : Array[String] = [
	"u think u know me",
	"...but u dont.........",
	"if u wanna test me ull have to stand toe 2 toe bub",
	"Come to Brazil :D"
]

@onready var _word_bubble : PackedScene = preload("res://word_bubble.tscn")

func _ready() -> void:
	texts = getTexts(dialogId)


func _process(delta: float) -> void:
	emitCountdown -= delta * timeFactor

	if (emitCountdown <= 0):
		emitCountdown = emitInterval
		
		var wb : Node2D = _word_bubble.instantiate()
		add_child(wb)
		
		wb.set_scale(Vector2(textSizeFactor, textSizeFactor))
		
		wb.get_node("Label").text = texts[textIndex]
		textIndex += 1
		if textIndex >= texts.size(): textIndex = 0
		
		var bubble : Bubble = Bubble.new()
		bubble.wordBubble = wb
		bubble.timeRemaining = bubbleLifetime
		bubbles.push_front(bubble)
	
	
	var i = bubbles.size() - 1
	while i >= 0:
		var bubble : Bubble = bubbles[i]
		bubble.timeRemaining -= delta * timeFactor
		
		if (bubble.timeRemaining <= bubbleLifetime):
			bubble.wordBubble.modulate.a = bubble.timeRemaining / bubbleFadeTime
		
		if (bubble.timeRemaining <= 0):
			bubble.wordBubble.queue_free()
			bubbles.remove_at(i)
			
		i -= 1
