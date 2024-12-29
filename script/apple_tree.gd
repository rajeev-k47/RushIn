extends Node2D

var state = "no_apples"
var player_area = false 

var apple = preload("res://scenes/apple_collectable.tscn")

func _ready():
		if state == "no_apples":
			$growth_Timer.start()
			
func _process(delta):
		if state == "no_apples":
			$AnimatedSprite2D.play("no_apples")
		if state== "apples":
			$AnimatedSprite2D.play("apples")
			if player_area:
				if Input.is_action_just_pressed("e"):
					print("enter")
					state = "no_apples"
					drop_apple()
			
			


func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_area=true


func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_area=false


func _on_growth_timer_timeout() -> void:
	if state=="no_apples":
		state="apples"

func drop_apple():
	var apple_instance = apple.instantiate()
	apple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_instance)
	
	await get_tree().create_timer(3).timeout
	$growth_Timer.start()
