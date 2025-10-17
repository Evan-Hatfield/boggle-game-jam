extends Node

const MAX_HEALTH = 100
var health = MAX_HEALTH
var lengthmod = 0
var dammult = 1
var treeroot

var currlevel = 0
var alliterator_checker = ""

var firstdamage = true

var relicsowned = [false, false, false, false, false, false]
var rollableindexes = [0, 1, 2, 3, 4, 5]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
