extends Control


var chest_state = false

@onready var chest : chest_m = preload("res://Chest/chest_items.tres")
@onready var chest_slots_grid = $NinePatchRect/GridContainer.get_children() as Array

func _ready():
	chest.updatechest.connect(updatechestSlots)
	updatechestSlots()

func updatechestSlots():
	for i in range(min(chest.chest_slots.size(),chest_slots_grid.size())):
		chest_slots_grid[i].update(chest.chest_slots[i])


				
			
