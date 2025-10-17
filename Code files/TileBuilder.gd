extends TileMap
			
func create_grid(word):
	for i in range(5):
		for j in range(5):
			var loc = "abcdefghijklmnopqrstuvwxyz".find(word[i][j])
			set_cell(1, Vector2i(i + 8, j + 4), 15, Vector2i(loc, 0), 0)

func make_board():
	var boggleBoard = []
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
	
	if (PlayerVars.relicsowned[3]):
		dice[9] = ['r', 's', 't', 'l', 'n', 'e']
		
	for i in range(25): #initializing an array with 25 ''
		boardString.append('')
	
	# filling the boardString with random characters 
	for i in range(25): 
		boardString[i] = dice[i][randi() % 5]
	
	# shuffling the board 
	for i in range(25):
		var j = i + randi() % (24 - i + 1);
		var c = boardString[j]
		boardString[j] = boardString[i]
		boardString[i] = c
	
	#Creating the 2D boggle board
	for i in range(5):
		var rowArray =[]
		for j in range(5):
			rowArray.append('')
		boggleBoard.append(rowArray)
	
	if (PlayerVars.relicsowned[4]):
		boardString[2] = "b"
		boardString[6] = "i"
		boardString[10] = "n"
		boardString[14] = "g"
		boardString[18] = "o"
		
	for i in range(5):
		for j in range(5):
			boggleBoard[i][j] = boardString[i* 4+ j]
	
	return boggleBoard
	
