extends Node

@onready var board = get_parent().board

func _ready() -> void:
	pass

func takeTurn():
	# check if the game will end next round
	var winner = get_winner_info()
	

func get_winner_info() -> Dictionary:
	var res = {"winner": null, "next_winning_move": null, "coords": null}
	var empty_cells = []
	
	for y in range(3):
		for x in range(3):
			if board[y][x] == "": empty_cells.append(Vector2i(x, y))

	for p in ["X", "O"]:
		# 1. Check Rows & Cols using a single loop
		for i in range(3):
			_eval([Vector2i(0,i), Vector2i(1,i), Vector2i(2,i)], p, res) # Row
			_eval([Vector2i(i,0), Vector2i(i,1), Vector2i(i,2)], p, res) # Col
			if res.winner: return res

		# 2. Check Diagonals
		_eval([Vector2i(0,0), Vector2i(1,1), Vector2i(2,2)], p, res)
		_eval([Vector2i(0,2), Vector2i(1,1), Vector2i(2,0)], p, res)
		if res.winner: return res

	# 3. Handle Draws
	if res.winner == null:
		if empty_cells.size() == 0: res.winner = "draw"
		elif empty_cells.size() == 1 and res.next_winning_move == null:
			res.next_winning_move = "draw"
			res.coords = empty_cells[0] # Returns the Vector2i of the last spot
			
	return res

func _eval(line, p, res):
	var count = 0
	var empty = null
	for pos in line:
		if board[pos.y][pos.x] == p: count += 1
		elif board[pos.y][pos.x] == "": empty = pos
	
	if count == 3: res.winner = p
	elif count == 2 and empty != null and res.next_winning_move == null:
		res.next_winning_move = p
		res.coords = empty
