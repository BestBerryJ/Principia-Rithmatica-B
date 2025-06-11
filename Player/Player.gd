@tool
extends Node

@export var anchor: Node2D
@export var shared_world: Node2D

func _process(_delta : float) -> void:
	if anchor:
		%DrawableArea.position = anchor.position
