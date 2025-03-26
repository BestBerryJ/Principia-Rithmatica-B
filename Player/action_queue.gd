extends Timer
class_name ActionQueue

var _current_action: Node
# I'm using the children list as a queue
# Change if we want non-node actions or have a large number of actions

func set_current_action(action: Node) -> void:
	_current_action = action
	start(_current_action.completion_time)

func enqueue(action: Node) -> void:
	# Why the duck does this language not have interfaces
	assert(action.has_method("complete") and \
		action.has_method("set_progress") and \
		action.get("completion_time") != null
	) 
	add_child(action)
	if get_child_count() == 1:
		set_current_action(action)
		
func _process(_delta: float) -> void:
	if not _current_action:
		return
	_current_action.set_progress(_current_action.completion_time - time_left)
	
func _on_timeout() -> void:
	if not _current_action:
		push_error("ActionQueue tried to dequeue nonexistent action")
		return
	_current_action.complete()
	remove_child(get_child(0))
	if get_child_count() == 0:
		_current_action = null
	else:
		set_current_action(get_child(0))
