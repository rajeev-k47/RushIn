extends Control

@onready var inv : Inv = preload("res://inventory/playerInv.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()


var is_open= false

func _ready():
	inv.update.connect(updateSlots)
	updateSlots()
	Invclose()

func updateSlots():
	for i in range(min(inv.slots.size(),slots.size())):
		slots[i].update(inv.slots[i])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("i"):
		if is_open:
			Invclose()
		else:
			Invopen()

func Invopen():
	visible = true
	is_open =true

func Invclose():
	visible = false
	is_open = false
