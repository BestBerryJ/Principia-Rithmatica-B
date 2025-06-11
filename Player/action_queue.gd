extends VFlowContainer
class_name ActionQueue

var _current_action: PlayerAction
var _timer : SceneTreeTimer

func set_current_action(action: PlayerAction) -> void:
	_current_action = action
	_timer = get_tree().create_timer(_current_action.completion_time)
	_timer.timeout.connect(_on_timeout)

func enqueue(action: PlayerAction) -> void:
	add_child(action)
	if get_child_count() == 1:
		set_current_action(action)
		
func _process(_delta: float) -> void:
	if not _current_action:
		return
	_current_action.set_progress(_current_action.completion_time - _timer.time_left)
	
func _on_timeout() -> void:
	if not _current_action:
		push_error("ActionQueue tried to dequeue nonexistent action")
		return
	_current_action.complete()
	remove_child(_current_action)
	_current_action.queue_free()
	
	if get_child_count() == 0:
		_current_action = null
	else:
		set_current_action(get_child(0))
