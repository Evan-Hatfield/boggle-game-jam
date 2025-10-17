extends Node2D

var file = 'res://bogglelist.txt'

const ALPHABET_SIZE = 26
const MAX_WORD_LENGTH = 12
const BOARD_SIZE = 5

var visited = []

var gridWordBank = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var root = TrieNode.new()
	
	var file = FileAccess.open("res://bogglelist.txt", FileAccess.READ)
	var content = file.get_as_text().split("\r\n")
	
	print(content)
	

	for word in content:
		insertWord(root, word)
	
	#var newBoard = [['q', 'b', 'z', 'j', 'x', 'k'], ['h', 'h', 'l', 'r', 'd', 'o'], ['t', 'e', 'l', 'p', 'c', 'i'],
	#			['t', 't', 'o', 't', 'e', 'm'], ['a', 'e', 'a', 'e', 'e', 'e']]
	#var newBoard = [['q', 'b', 'z', 'j', 'x'], ['h', 'h', 'l', 'r', 'd'], ['t', 'e', 'l', 'p', 'c'],
	#			['t', 't', 'o', 't', 'e'], ['a', 'e', 'a', 'e', 'e']]
	var newBoard = [['b', 'c', 'p', 'v', 's'], ['s', 'f', 'r', 'm', 'v'], ['d', 'r', 'o', 'u', 'f'],
				['f', 'h', 's', 's', 'n'], ['n', 't', 'i', 'n', 'a']]
				
	for i in range(BOARD_SIZE):
		for j in range(BOARD_SIZE):
			print(newBoard[i][j], " ")
		print("\n")
		
	

	solveGrid(newBoard, root)
	#searchEveryWord()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

	
class TrieNode:
	var children = []
	var isEndOfWord = false

	func _init():
		children = []
		for i in range(26):
			children.append(null)
		isEndOfWord = false



func insertWord(root, word):
	var current = root
	var ASCII_index = {
		'a' : 0, 
		'b' : 1,
		'c' : 2,
		'd' : 3, 
		'e' : 4, 
		'f' : 5,
		'g' : 6, 
		'h' : 7, 
		'i' : 8,
		'j' : 9,
		'k' : 10, 
		'l' : 11, 
		'm' : 12,
		'n' : 13, 
		'o' : 14, 
		'p' : 15,
		'q' : 16,
		'r' : 17,
		's' : 18,
		't' : 19,
		'u' : 20,
		'v' : 21,
		'w' : 22,
		'x' : 23,
		'y' : 24,
		'z' : 25
	}

	for letter in word:
		var idx = ASCII_index[letter]
		if not current.children[idx]:
			current.children[idx] = TrieNode.new()
		current = current.children[idx]
	current.isEndOfWord = true
	#print("added: " + word + "\n")


func insertToWordBank(word, length):
	if length <= MAX_WORD_LENGTH:
		gridWordBank.append(word)
		print("found: ", word)


func solveRecursive(board, node, visited, x, y, currWord, length):
	if x < 0 || x >= BOARD_SIZE || y < 0 || y >= BOARD_SIZE || visited[x][y]:
		return
	var ASCII_index = {
		'a' : 0, 
		'b' : 1,
		'c' : 2,
		'd' : 3, 
		'e' : 4, 
		'f' : 5,
		'g' : 6, 
		'h' : 7, 
		'i' : 8,
		'j' : 9,
		'k' : 10, 
		'l' : 11, 
		'm' : 12,
		'n' : 13, 
		'o' : 14, 
		'p' : 15,
		'q' : 16,
		'r' : 17,
		's' : 18,
		't' : 19,
		'u' : 20,
		'v' : 21,
		'w' : 22,
		'x' : 23,
		'y' : 24,
		'z' : 25
	}
	
	var idx = ASCII_index[board[x][y]]
	if not node.children[idx]:    
		return

	visited[x][y] = true
	currWord[length] = board[x][y]
	length += 1

	if node.children[idx].isEndOfWord:
		currWord[length] = ''
		insertToWordBank(currWord, length)

	var dx = [-1, -1, -1, 0, 0, 1, 1, 1]
	var dy = [-1, 0, 1, -1, 1, -1, 0, 1]

	for i in range(8):
		solveRecursive(board, node.children[idx], visited, x + dx[i], y + dy[i], currWord, length)

	visited[x][y] = false
	currWord[length] = ''


func solveGrid(board, root):
	
	
	for i in range(BOARD_SIZE):
		var tempArray = []
		for j in range(BOARD_SIZE):
			tempArray.append("")
			
		visited.append(tempArray)
	
	var currWord = ""
	for i in range(BOARD_SIZE * BOARD_SIZE):
		currWord += " "
	for i in range(BOARD_SIZE):
		for j in range(BOARD_SIZE):
			solveRecursive(board, root, visited, i, j, currWord, 0)


func searchWord(root, word):
	var current = root
	var ASCII_index = {
		'a' : 0, 
		'b' : 1,
		'c' : 2,
		'd' : 3, 
		'e' : 4, 
		'f' : 5,
		'g' : 6, 
		'h' : 7, 
		'i' : 8,
		'j' : 9,
		'k' : 10, 
		'l' : 11, 
		'm' : 12,
		'n' : 13, 
		'o' : 14, 
		'p' : 15,
		'q' : 16,
		'r' : 17,
		's' : 18,
		't' : 19,
		'u' : 20,
		'v' : 21,
		'w' : 22,
		'x' : 23,
		'y' : 24,
		'z' : 25
	}

	for letter in word:
		var idx = ASCII_index[letter]
		if not current.children[idx]:
			return false
		current = current.children[idx]

	return current and current.isEndOfWord


func dfsSearch(node, word, depth):
	var ASCII_index = {
		'a' : 0, 
		'b' : 1,
		'c' : 2,
		'd' : 3, 
		'e' : 4, 
		'f' : 5,
		'g' : 6, 
		'h' : 7, 
		'i' : 8,
		'j' : 9,
		'k' : 10, 
		'l' : 11, 
		'm' : 12,
		'n' : 13, 
		'o' : 14, 
		'p' : 15,
		'q' : 16,
		'r' : 17,
		's' : 18,
		't' : 19,
		'u' : 20,
		'v' : 21,
		'w' : 22,
		'x' : 23,
		'y' : 24,
		'z' : 25
	}
	
	for i in range(ALPHABET_SIZE):
		if node.children[i]:
			word[depth] = ASCII_index.get_key(i)
			dfsSearch(node.children[i], word, depth + 1)


func searchEveryWord():
	for i in range(MAX_WORD_LENGTH):
		var currentTrie = gridWordBank[i]
		if currentTrie:
			var word = ""
			dfsSearch(currentTrie, word, 0)
