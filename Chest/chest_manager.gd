extends Resource

class_name chest_m

signal updatechest

@export var chest_slots:Array[InvSlot]

func insert_to_chest(item:Invitem):
	var itemslots = chest_slots.filter(func(slot): return slot.item == item)
	if !itemslots.is_empty():
		itemslots[0].amount+=1
	
	else:
		var emptyslots = chest_slots.filter(func(slot):return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount =1
	
	updatechest.emit()
