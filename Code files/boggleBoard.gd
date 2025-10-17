extends Node2D

var boggleBoard = []

# Called when the node enters the scene tree for the first time.
func _ready():
	make_board()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_board():
	var dice = [
			['q', 'b', 'z', 'j', 'x', 'k'],
			['h', 'h', 'l', 'r', 'd', 'o'],
			['t', 'e', 'l', 'p', 'c', 'i'],
			['t', 't', 'o', 't', 'e', 'm'],
			['a', 'e', 'a', 'e', 'e', 'e'],
			['t', 'o', 'u', 'o', 't', 'o'],
			['n', 'h', 'd', 't', 'h', 'o'],
			['s', 's', 'n', 's', 'e', 'u'],
			['s', 'c', 't', 'i', 'e', 'p'],
			['y', 'i', 'f', 'p', 's', 'r'],
			['o', 'v', 'w', 'r', 'g', 'r'],
			['l', 'h', 'n', 'r', 'o', 'd'],
			['r', 'i', 'y', 'p', 'r', 'h'],
			['e', 'a', 'n', 'd', 'n', 'n'],
			['e', 'e', 'e', 'e', 'm', 'a'],
			['a', 'a', 'a', 'f', 's', 'r'],
			['a', 'f', 'a', 'i', 's', 'r'],
			['d', 'o', 'r', 'd', 'l', 'n'],
			['m', 'n', 'n', 'e', 'a', 'g'],
			['i', 't', 'i', 't', 'i', 'e'],
			['a', 'u', 'm', 'e', 'e', 'g'],
			['y', 'i', 'f', 'a', 's', 'r'],
			['c', 'c', 'w', 'n', 's', 't'],
			['u', 'o', 't', 'o', 'w', 'n'],
			['e', 't', 'i', 'l', 'i', 'c'],
	]
	var boardString = [] #declaring an array 
		
	for i in range(25): #initializing an array with 25 ''
		boardString.append('')
	print(boardString)
	
	# filling the boardString with random characters 
	for i in range(25): 
		boardString[i] = dice[i][randi() % 6]
	print(boardString)
	
	# shuffling the board 
	for i in range(25):
		var j = i + randi() % (24 - i + 1);
		var c = boardString[j]
		boardString[j] = boardString[i]
		boardString[i] = c
	print(boardString)
	
	#Creating the 2D boggle board
	for i in range(5):
		var rowArray =[]
		for j in range(5):
			rowArray.append('')
		boggleBoard.append(rowArray)
	print(boggleBoard)
	
	for i in range(5):
		for j in range(5):
			boggleBoard[i][j] = boardString[i* 4+ j]
	print(boggleBoard)
	
