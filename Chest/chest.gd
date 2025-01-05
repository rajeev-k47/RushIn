extends Node2D


var state = "closed"
var area_entered =false

func _ready() -> void:
	$Chest_inv.visible=false
	

func _process(_delta):
		if state=="closed":
			$AnimatedSprite2D.play("close")
			if  Input.is_action_just_pressed("open_chest") and area_entered:
				state = "open"
				$Chest_inv.visible=true
				await get_tree().create_timer(0.3).timeout

		if state =="open":
			$AnimatedSprite2D.play("open")
			if  Input.is_action_just_pressed("open_chest") and area_entered:
				state ="closed"
				$Chest_inv.visible=false
				await get_tree().create_timer(0.3).timeout
			if !area_entered:
				state ="closed"
				$Chest_inv.visible=false
				await get_tree().create_timer(0.3).timeout

			
		
			
	
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
			area_entered=true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.has_method("player"):
			area_entered=false
		
