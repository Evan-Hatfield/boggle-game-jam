extends Node2D

var time_frame_candle = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_frame_candle += delta
	if(time_frame_candle > .5):
		$candle1.visible = false
		$candle2.visible = true
		$candle3.visible = false
		
	if(time_frame_candle > 1):
		$candle1.visible = false
		$candle2.visible = false
		$candle3.visible = true
		
	if(time_frame_candle > 1.5):
		$candle1.visible = false
		$candle2.visible = true
		$candle3.visible = true
		time_frame_candle = 0
		
