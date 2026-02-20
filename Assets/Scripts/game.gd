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
@onready var Main = get_parent()

var turn: String = 'X'
var inGame := true

func _ready() -> void:
	for r in range(buttons.size()):
			for c in range(buttons[r].size()):
				var button = buttons[r][c]
				if button:
					button.pressed.connect(_on_button_pressed.bind(r, c))
	$"Game End/Replay".pressed.connect(Callable(Main, "play"))
	$"Game End/Quit".pressed.connect(Callable(Main, "_ready"))
	$"Game End/Quit".pressed.connect(queue_free)
	updateLabels()

func _on_button_pressed(r: int, c: int):
	inGame = false;
	for i in range(board.size()): if "" in board[i]: inGame = true
	if inGame:
		board[r][c] = turn
		updateLabels()
		
		turn = 'O'
		inGame = Bot.takeTurn()
		turn = 'X'
		updateLabels()
	if !inGame:
		if str(check_game_state("X")) == "draw": $"Draw".show(); $"Game End".show()
		elif check_game_state("X"): $"Player win".show(); $"Game End".show()
		elif check_game_state("O"): $"Bot win".show(); $"Game End".show()

func check_game_state(player: String) -> Variant:
	# 1. Check for a Win
	# Rows & Columns
	for i in range(3):
		if board[i][0] == player and board[i][1] == player and board[i][2] == player:
			return true
		if board[0][i] == player and board[1][i] == player and board[2][i] == player:
			return true
			
	# Diagonals
	if board[0][0] == player and board[1][1] == player and board[2][2] == player:
		return true
	if board[0][2] == player and board[1][1] == player and board[2][0] == player:
		return true

	# 2. Check for a Draw (if no winner and board is full)
	var is_full = true
	for row in board:
		if "" in row: # Found an empty space
			is_full = false
			break
			
	if is_full:
		return "draw"

	# 3. Game still in progress
	return false


func updateLabels():
	for r in range(board.size()):
		for c in range(board[0].size()):
			labels[r][c].text = board[r][c]
			if labels[r][c].text != '': buttons[r][c].disabled = true
