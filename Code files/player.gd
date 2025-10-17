extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_health_label()
	set_health_bar()

func set_health_label() -> void:
	$PlayerHealth.text = "Health %s" % PlayerVars.health

func set_health_bar() -> void:
	$PlayerBar.value = PlayerVars.health


func damage(dam) -> void:
	PlayerVars.health -= dam
	if PlayerVars.health < 0:
		get_tree().change_scene_to_file("res://gameover/gameover.tscn")
	set_health_label()
	set_health_bar()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
