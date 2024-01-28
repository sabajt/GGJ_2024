extends Node

enum PATH_CORRECTNESS {
	INCORRECT,
	CORRECT_SO_FAR,
	COMPLETED,
}

const correct_path : Array[String] = ["res://eyeball.tscn/", "res://eyeball.tscn/"]

var current_path : Array[String] = []
var path_correctness : PATH_CORRECTNESS = PATH_CORRECTNESS.CORRECT_SO_FAR


func go_down_path (name:String) -> void:
	current_path.push_front(name)
	_evaluate_path_correctness()
	
func go_up_path () -> void:
	if current_path.size() == 0:
		print("current_path length is 0")
		return
	
	current_path.pop_back()
	_evaluate_path_correctness()
	
func _evaluate_path_correctness () -> void:
	var newState : PATH_CORRECTNESS = PATH_CORRECTNESS.CORRECT_SO_FAR
	
	var i = 0
	while i < current_path.size():
		var cor : String = correct_path[i]
		var cur : String = current_path[i]
		if cor != cur:
			newState = PATH_CORRECTNESS.INCORRECT
			break
		i += 1
	
	if newState == PATH_CORRECTNESS.CORRECT_SO_FAR && correct_path.size() == current_path.size():
		newState = PATH_CORRECTNESS.COMPLETED
	
	path_correctness = newState
