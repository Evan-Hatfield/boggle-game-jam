extends Node2D

var MAX_HEALTH = 30;
var health = MAX_HEALTH
var childs

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health_label()
	set_health_bar()

func set_health_label() -> void:
	$EnemyHealth.text = "Health %s" % health

func set_health_bar() -> void:
	$EnemyBar.value = health


func damage(dam, child) -> void:
	childs = child
	health -= dam
	if health <= 0:
		combatended()
	set_health_label()
	set_health_bar()
	
func combatended():
	var rem = randi_range(0, len(PlayerVars.rollableindexes) - 1)
	var index = PlayerVars.rollableindexes[rem]
	PlayerVars.rollableindexes.remove_at(rem)
	PlayerVars.relicsowned[index] = true
	
	if(index == 0):
		PlayerVars.dammult = 3
	if(index == 1):
		PlayerVars.lengthmod = 1
	if(index == 2):
		PlayerVars.lengthmod = 2
	
	childs[index].visible
	if(PlayerVars.currlevel == 2):
		PlayerVars.currlevel += 1
		get_tree().change_scene_to_file("res://Boss1/Boss1.tscn")
	elif(PlayerVars.currlevel == 5):
		PlayerVars.currlevel += 1
		get_tree().change_scene_to_file("res://Boss2/Boss2.tscn")
	else:
		PlayerVars.currlevel += 1
		get_tree().change_scene_to_file("res://stage2/stage2.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
