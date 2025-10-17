extends Node2D

# Declare an AudioStreamPlayer node as a class member and load SFX
var sound_player := AudioStreamPlayer.new()
var sound_effect = load("res://Roll_2d6.wav")
#Used for playing background music
var bg_music := AudioStreamPlayer.new()

#list of all the correct words that have been used by the enemy 
var correctWordsList = []

var time_since_enabled = 0

const ALPHABET_SIZE = 26
const MAX_WORD_LENGTH = 12
const BOARD_SIZE = 5

var visited = []
var lookupdam = [0, 0, 0, 5, 6, 8, 11, 14, 18, 23, 29, 36, 44]
var gridWordBank = []
var childs
var wrongWordCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVars.firstdamage = true
	childs = $rename/TextureRect/HBoxContainer/VBoxContainer2.get_children()
	
	# May not play after boss is defeated
	bg_music.stream = load("res://gear_up_flip_melody_116bpm.mp3")
	bg_music.autoplay = true
	bg_music.volume_db = -20
	add_child(bg_music)
	if(PlayerVars.currlevel == 2):
		$enemy.health = 50
	if(PlayerVars.currlevel == 5):
		$enemy.health = 70

	#get_tree().change_scene_to_file("res://gameover/gameover.tscn")
	var board_array = $Board.make_board()
	$Board.create_grid(board_array)
	
	var root = PlayerVars.treeroot
	
	solveGrid(board_array, root)
	
	#Add the AudioStreamPlayer as a child to the player node
	add_child(sound_player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enter"):
		var wordin = $LineEdit.text
		var goodWord = querylist(wordin)
		var alliteratorWord = wordin[0]
		var relicPasser = true
		
		if (PlayerVars.alliterator_checker == "" and goodWord):
			PlayerVars.alliterator_checker = alliteratorWord
			
		if (goodWord): 
			
			
			if (!(PlayerVars.alliterator_checker == alliteratorWord) and PlayerVars.relicsowned[0]):
				relicPasser = false
			if (len(wordin) >= 4 and PlayerVars.relicsowned[2]):
				relicPasser = false
			
			if (relicPasser == true):
				sound_player.stream = sound_effect
				sound_player.play()
				$found.visible = true
				time_since_enabled = 0
				$TextEdit.text = wordin + "\n" + $TextEdit.text
				correctWordsList.append(wordin)
				attack(wordin)
				$ungabunga.take_damage()
				correctWordsList.append(defend())
				
			else:
				$notfound.visible = true
				time_since_enabled = 0
				wrongWordCount += 1
				if (wrongWordCount == 3):
					wrongWordCount = 0
					correctWordsList.append(defend())
				
		else:
			$notfound.visible = true
			wrongWordCount += 1
			if (wrongWordCount == 3):
				wrongWordCount = 0
				correctWordsList.append(defend())
			time_since_enabled = 0
				
	time_since_enabled += delta
	if(time_since_enabled > 2):
		$found.visible = false
		$notfound.visible = false
	#if Input.is_action_just_pressed("enter"):
		#var wordin = $LineEdit.text 
		#if querylist(wordin):
			#$found.visible = true
			#time_since_enabled = 0
			#$TextEdit.text += wordin + "\n"
			#attack(wordin)
			##await get_tree().create_timer(2.0).timeout
			#defend()
		#else:
			#$notfound.visible = true
			#time_since_enabled = 0
	#time_since_enabled += delta
	#if(time_since_enabled > 2):
		#$found.visible = false
		#$notfound.visible = false
		#
	
		
func attack(wordin):
	var damage
	var length = len(wordin) + PlayerVars.lengthmod
	damage = lookupdam[length]
	damage *= PlayerVars.dammult
	$enemy.damage(damage, childs)
	return
	
func defend():
	var damage
	var enemyword
	
	#for word in gridWordBank:
		#if (len(word.rstrip(" ")) > 5):
			#gridWordBank.erase(word)
			#enemyword = word
			#break
	enemyword = gridWordBank[randi_range(0, len(gridWordBank) - 1)].rstrip(" ")
	gridWordBank.erase(enemyword)
		
	damage = lookupdam[len(enemyword.rstrip(" "))]
	$TextEdit.text += enemyword + "\n"
	$player.damage(damage)
	return enemyword
	
func querylist(word):
	for goodword in gridWordBank:
		var out = goodword.rstrip(" ")
		if(word == out):
			$LineEdit.clear()
			return true
	$LineEdit.clear()
	return false
	
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



func insertToWordBank(word, length):
	if length <= MAX_WORD_LENGTH:
		gridWordBank.append(word)



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

