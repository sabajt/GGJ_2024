extends Node2D

enum DIALOG_ID {
	SONG_LYRICS
}

const TEXT_SONG_LYRICS : Array[String] = [
	"On out west he sees you now",
	"Through this tune you may see how",
	"Visit me at my peepaw's grave",
	"Down in east nostril place",
	"Deeper in you'll come back here",
	"Deeper yet we'll still be here",
	"And did you know, did you hear?",
	"Do you hear us in northeastern ear?",
	"You may be a feline but to tell you the truth",
	"He'll brush your west upper canine tooth",
	"And to finish it off, floss away",
	"With ninth whisker - that's the way",
]

class Bubble:
	var timeRemaining : float = 0.0
	var wordBubble : Node2D

func getTexts (id:DIALOG_ID) -> Array[String]:
	match id:
		DIALOG_ID.SONG_LYRICS: return TEXT_SONG_LYRICS
	return []

const timeFactor : float = 100

@export var bubbleLifetime : float = 325
const bubbleFadeTime : float = 100

@export var emitInterval : float = 500

var emitCountdown : float = 100.0
var bubbles : Array[Bubble] = []

@export var dialogId : DIALOG_ID = DIALOG_ID.SONG_LYRICS
@export var textSizeFactor : float = 1.0
@export var textRotation : float = 0.0

var textIndex : int = 0
var texts : Array[String] = [
]

@onready var _word_bubble : PackedScene = preload("res://word_bubble.tscn")

func _ready() -> void:
	texts = getTexts(dialogId)


func _process(delta: float) -> void:
	emitCountdown -= delta * timeFactor
	
	if texts.size() == 0: return

	if (emitCountdown <= 0):
		emitCountdown = emitInterval
		
		var wb : Node2D = _word_bubble.instantiate()
		add_child(wb)
		
		wb.set_rotation(textRotation)
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
