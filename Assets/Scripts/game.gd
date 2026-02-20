extends Control

@onready var buttons: Array[Array] = [
	[$PanelContainer/GridContainer/TL, $PanelContainer/GridContainer/TC, $PanelContainer/GridContainer/TR],
	[$PanelContainer/GridContainer/ML, $PanelContainer/GridContainer/MC, $PanelContainer/GridContainer/MR],
	[$PanelContainer/GridContainer/BL, $PanelContainer/GridContainer/BC, $PanelContainer/GridContainer/BR]
]
var board: Array[Array] = [
	["", "", ""],
	["", "", ""],
	["", "", ""]
]

func _ready() -> void:
	for r in range(buttons.size()):
		for c in range(buttons[r].size()):
			var button = buttons[r][c]
			if button:
				button.pressed.connect(_on_button_pressed.bind(r, c))

func _on_button_pressed(r: int, c: int):
	pass
