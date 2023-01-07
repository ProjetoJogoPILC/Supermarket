extends Node2D


# Declare member variables here. Examples:
var slots = []


# Called when the node enters the scene tree for the first time.
func _ready():
	slots = [$Slot1, $Slot2, $Slot3, $Slot4]
	$Sprite.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var order = []
	for slot in slots:
		var bodies = slot.get_overlapping_areas()
		if len(bodies) == 1:
			if bodies[0].is_in_group("box"):
				order.append(bodies[0])
		else:
			# TODO: write warning of two boxes in pallet
			pass
	if check_if_in_order(order) and order.size() > 1:
		$Sprite.show()
	else:
		$Sprite.hide()

func check_if_in_order(a):
	for i in range(a.size() - 1):
		if a[i].validade > a[i+1].validade:
			return false
	return true
