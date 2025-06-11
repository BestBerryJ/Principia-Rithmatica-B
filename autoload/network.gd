extends Node

var peer: ENetMultiplayerPeer
const DEFAULT_PORT := 8910

var players : Dictionary = {}
var player_info : Dictionary = {}

signal player_connected(peer_id : int, player_info : Dictionary)
signal player_disconnected(peer_id : int)
signal server_disconnected

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_player_connected)
	#multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	#multiplayer.connection_failed.connect(_on_connected_fail)
	#multiplayer.server_disconnected.connect(_on_server_disconnected)

func host(port: int = DEFAULT_PORT, max_clients: int = 8) -> void:
	if (peer != null):
		push_error("Network peer already instantiated")
		return
	peer = ENetMultiplayerPeer.new()
	var err := peer.create_server(port, max_clients)
	if err != OK:
		push_error("Failed to host on port %d (err=%d)" % [port, err])
		return
	multiplayer.multiplayer_peer = peer
	_register_player(player_info)
	print("Hosting on port %d" % port)

func join(address: String = "127.0.0.1", port: int = DEFAULT_PORT) -> void:
	if (peer != null):
		push_error("Network peer already instantiated")
		return
	peer = ENetMultiplayerPeer.new()
	var err := peer.create_client(address, port)
	if err != OK:
		push_error("Failed to connect to %s:%d (err=%d)" % [address, port, err])
		return
	multiplayer.multiplayer_peer = peer
	print("Connecting to %s:%d" % [address, port])

func _on_player_connected(id: int) -> void:
	_register_player.rpc_id(id, player_info)
	
func _on_connected_ok() -> void:
	var peer_id : int = multiplayer.get_unique_id()
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)

@rpc("any_peer", "reliable")
func _register_player(new_player_info : Dictionary) -> void:
	var new_player_id : int = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit(new_player_id, new_player_info)


