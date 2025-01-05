extends CharacterBody2D

var speed =120
var player_state

@export var inv : Inv

var bow_equied = false
var bow_cooldown = true

var arrow  = preload("res://scenes/Arrow.tscn")

var mouse_loc_from_player = null
func _physics_process(_delta):
	mouse_loc_from_player= get_global_mouse_position()- self.position
	
	var direction = Input.get_vector("left","right","up","down")
	if direction.x==0 and direction.y ==0:
		player_state="idle"
	elif direction.x !=0 or direction.y!=0:
		player_state="walking"
	
	velocity = direction*speed
	move_and_slide() 
	if Input.is_action_just_pressed("b"):
			bow_equied= !bow_equied
			
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left_mouse") and bow_equied and bow_cooldown:
		bow_cooldown=false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.4).timeout
		bow_cooldown=true
	
	
	play_animation(direction)
	


func play_animation(dir):
	if !bow_equied:
		if player_state == "idle":
			$AnimatedSprite2D.play("idle")
		if player_state == "walking":
			if dir.y==-1:
				$AnimatedSprite2D.play("n-walk")
			if dir.x ==1:
				$AnimatedSprite2D.play("e-walk")
			if dir.y ==1:
				$AnimatedSprite2D.play("s-walk")
			if dir.x ==-1:
				$AnimatedSprite2D.play("w-walk")
			
			if dir.x >0.5 and dir.y< -0.5:
				$AnimatedSprite2D.play("ne-walk")
			if dir.x>0.5 and dir.y >0.5:
				$AnimatedSprite2D.play("se-walk")
			if dir.x < -0.5 and dir.y > 0.5:
				$AnimatedSprite2D.play("sw-walk")
			if dir.x < -0.5 and dir.y<-0.5:
				$AnimatedSprite2D.play("nw-walk")
	else:
		if mouse_loc_from_player.x>= -25 and mouse_loc_from_player.x <=25 and mouse_loc_from_player.y <0:
			$AnimatedSprite2D.play("n-attack")
		if mouse_loc_from_player.y>= -25 and mouse_loc_from_player.y <=25 and mouse_loc_from_player.x >0:
			$AnimatedSprite2D.play("e-attack")
		if mouse_loc_from_player.x>= -25 and mouse_loc_from_player.x <=25 and mouse_loc_from_player.y > 0:
			$AnimatedSprite2D.play("s-attack")
		if mouse_loc_from_player.y>= -25 and mouse_loc_from_player.y <=25 and mouse_loc_from_player.x <0:
			$AnimatedSprite2D.play("w-attack")
			
		if mouse_loc_from_player.x>=25 and mouse_loc_from_player.y <=-25:
			$AnimatedSprite2D.play("ne-attack")
		if mouse_loc_from_player.x>=0.5 and mouse_loc_from_player.y >=25:
			$AnimatedSprite2D.play("se-attack")
		if mouse_loc_from_player.x<=-0.5 and mouse_loc_from_player.y >=25:
			$AnimatedSprite2D.play("sw-attack")
		if mouse_loc_from_player.x<= -25 and mouse_loc_from_player.y <=-25:
			$AnimatedSprite2D.play("nw-attack")
			
			
			
func player():
	pass

func collect(item):
	inv.insert(item)
