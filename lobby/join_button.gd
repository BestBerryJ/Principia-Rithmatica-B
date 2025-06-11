extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	Network.player_info = {"Name": "client"}
	Network.join()
