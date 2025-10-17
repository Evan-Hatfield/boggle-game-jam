extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if(PlayerVars.relicsowned[0]):
		enable_sprite(0)
	if(PlayerVars.relicsowned[1]):
		enable_sprite(1)
	if(PlayerVars.relicsowned[2]):
		enable_sprite(2)
	if(PlayerVars.relicsowned[3]):
		enable_sprite(3)
	if(PlayerVars.relicsowned[4]):
		enable_sprite(4)
	if(PlayerVars.relicsowned[5]):
		enable_sprite(5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enable_sprite(integer):
	if(integer == 0):
		$TextureRect/HBoxContainer/VBoxContainer2/Panel.visible = true
	if(integer == 1):
		$TextureRect/HBoxContainer/VBoxContainer2/Panel2.visible = true
	if(integer == 2):
		$TextureRect/HBoxContainer/VBoxContainer2/Panel3.visible = true
	if(integer == 3):
		$TextureRect/HBoxContainer/VBoxContainer2/Panel4.visible = true
	if(integer == 4):
		$TextureRect/HBoxContainer/VBoxContainer2/Panel5.visible = true
	if(integer == 5):
		$TextureRect/HBoxContainer/VBoxContainer2/Panel6.visible = true
	
	
	

func _on_panel_mouse_entered():
	print("Entered")


func _on_panel_2_mouse_entered():
	pass # Replace with function body.
