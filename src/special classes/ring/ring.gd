extends Node

class_name Ring

var data: Array = []
var current_index: int
var iter_index: int
var iter_counter: int

func _init(data: Array = []):
	current_index = 0
	self.data = data


func _iter_init(arg):
	iter_index = current_index
	iter_counter = 0;
	return iter_counter < data.size()


func _iter_next(arg): #it is dublicated from next()...
	iter_index = (iter_index + 1) % data.size()
	iter_counter += 1
	return iter_counter < data.size()


func _iter_get(arg):
	return data[iter_index]


func next() -> Variant:
	current_index = (current_index + 1) % data.size()
	return data[current_index]


func current() -> Variant:
	return data[current_index]


func size() -> int:
	return data.size()


func push_back(e: Variant):
	data.push_back(e)


func get_element(number: int) -> Variant:
	if number > data.size():
		printerr("no such element: " + str(number))
		return null
	return data[number]	
