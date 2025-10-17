extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Board2.create_grid()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("enter"):
		get_tree().change_scene_to_file("res://TileSets/tile_map.tscn")
	pass
