extends TileMap
			
func create_grid():
		set_cell(1, Vector2i(8, 4), 15, Vector2i(6, 0), 0)
		set_cell(1, Vector2i(9, 4), 15, Vector2i(0, 0), 0)
		set_cell(1, Vector2i(10, 4), 15, Vector2i(12, 0), 0)
		set_cell(1, Vector2i(11, 4), 15, Vector2i(4, 0), 0)
		
		set_cell(1, Vector2i(8, 5), 15, Vector2i(14, 0), 0)
		set_cell(1, Vector2i(9, 5), 15, Vector2i(21, 0), 0)
		set_cell(1, Vector2i(10, 5), 15, Vector2i(4, 0), 0)
		set_cell(1, Vector2i(11, 5), 15, Vector2i(17, 0), 0)
# Called when the node enters the scene tree for the first time.
func _ready():
	create_grid()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
