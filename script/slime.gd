extends CharacterBody2D


var speed = 50
var health  = 100
var dead = false
var player_in_area = false
var player

@onready var slime = $slime_collectable
@export var item_Resource:Invitem

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


func _on_hitbox_area_entered(area: Area2D) -> void:
	var damage
	if area.has_method("arrow_deal_damage"):
		damage=50
		take_damage(damage)

func take_damage(damage):
	health = health-damage
	if health <=0 and !dead:
		death()
		
func death():
	dead = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout
	drop_slime()
	
	$AnimatedSprite2D.visible = false
	$hitbox/CollisionShape2D.disabled = true
	$detection_area/CollisionShape2D.disabled = true

func drop_slime():
	slime.visible = true
	$slime_collect_area/CollisionShape2D.disabled=false
	slime_collect()
	
func slime_collect():
	await get_tree().create_timer(1.5).timeout
	slime.visible = false
	player.collect(item_Resource)
	queue_free()
	

func _on_hitbox_area_exited(area: Area2D) -> void:
	pass


func _on_slime_collect_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player=body
