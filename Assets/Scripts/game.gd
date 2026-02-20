extends Control

@onready var buttons: Array[Array] = [
	[$PanelContainer/GridContainer/TL, $PanelContainer/GridContainer/TC, $PanelContainer/GridContainer/TR],
	[$PanelContainer/GridContainer/ML, $PanelContainer/GridContainer/MC, $PanelContainer/GridContainer/MR],
	[$PanelContainer/GridContainer/BL, $PanelContainer/GridContainer/BC, $PanelContainer/GridContainer/BR]
]
@onready var labels: Array[Array] = [
	[$PanelContainer/GridContainer2/TL, $PanelContainer/GridContainer2/TC, $PanelContainer/GridContainer2/TR],
	[$PanelContainer/GridContainer2/ML, $PanelContainer/GridContainer2/MC, $PanelContainer/GridContainer2/MR],
	[$PanelContainer/GridContainer2/BL, $PanelContainer/GridContainer2/BC, $PanelContainer/GridContainer2/BR]
]
var board: Array[Array] = [
	["", "", ""],
	["", "", ""],
	["", "", ""]
]
@onready var Bot = $Bot

var turn: String = 'X'
var inGame := true

func _ready() -> void:
	for r in range(buttons.size()):
			for c in range(buttons[r].size()):
				var button = buttons[r][c]
				if button:
					button.pressed.connect(_on_button_pressed.bind(r, c))
	updateLabels()

func _process(delta: float) -> void:
	if inGame and turn == 'X':
		pass

func _on_button_pressed(r: int, c: int):
	inGame = false;
	for i in range(board.size()): if "" in board[i]: inGame = true
	if inGame:
		board[r][c] = turn
		updateLabels()
		
		turn = 'O'
		Bot.takeTurn()
		turn = 'X'
		updateLabels()

func updateLabels():
	for r in range(board.size()):
		for c in range(board[0].size()):
			labels[r][c].text = board[r][c]
