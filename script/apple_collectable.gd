extends Node2D


func _ready():
	fallfromtree()

func fallfromtree():
	$AnimationPlayer.play("falling_apple_tree")
	await get_tree().create_timer(1.5).timeout
	$AnimationPlayer.play("fade_anim")
	await get_tree().create_timer(0.5).timeout
	queue_free()
