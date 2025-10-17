extends Node2D

var time_frame_boss = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_frame_boss += delta
	if(time_frame_boss > .5):
		$ungabunga1.visible = false
		$ungabunga2.visible = true
		
	if(time_frame_boss > 1):
		$ungabunga1.visible = true
		$ungabunga2.visible = false
		time_frame_boss = 0

func take_damage():
	$AnimationPlayer.play("take_damage")
