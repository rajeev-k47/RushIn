extends CharacterBody2D


var speed = 50
var health  = 100
var damage 
var dead = false
var player_in_area = false
var player

func _ready():
	dead = false
	
func _physics_process(delta: float) -> void:
	if !dead:
		$detection_area/CollisionShape2D.disabled=false
		
		if player_in_area:
			position += (player.position- position)/speed
			$AnimatedSprite2D.play("move")
		else:
			$AnimatedSprite2D.play("idle")
	
	if dead:
		$detection_area/CollisionShape2D.disabled=true
		

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area=true
		player=body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area=false
