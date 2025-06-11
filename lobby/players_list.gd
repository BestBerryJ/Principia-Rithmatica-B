extends GridContainer

func _ready() -> void:
	Network.player_connected.connect(
		func(_id : int, _info : Dictionary) -> void: \
		 show_info(Network.players)
		)

func show_info(info: Dictionary) -> void:
	for child in get_children():
		child.queue_free()
		
	for key : int in info.keys():
		var key_label := Label.new()
		key_label.text = str(key)
		var value_label := Label.new()
		value_label.text = str(info[key])
		add_child(key_label)
		add_child(value_label)
