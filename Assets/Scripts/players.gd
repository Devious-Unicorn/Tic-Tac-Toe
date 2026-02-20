extends Control

@onready var onePlayer := $"PanelContainer/VBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer/one player"
@onready var twoPlayer := $"PanelContainer/VBoxContainer2/VBoxContainer/HBoxContainer/VBoxContainer2/two player"

func _ready() -> void:
	onePlayer.pressed.connect(onePlayerPressed)
	twoPlayer.pressed.connect(twoPlayerPressed)

func onePlayerPressed():
	pass

func twoPlayerPressed():
	pass
