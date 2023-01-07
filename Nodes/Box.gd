extends Area2D

export var validade = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("box")
	$"Pickup Sign".hide()
	$"Pickup Sign".text = str(validade)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.

func get_picked():
	disable_pickup()
	self.hide()
	self.monitoring = false

func drop(position):
	self.position = position
	self.show()
	self.monitoring = true

func enable_pickup():
	$"Pickup Sign".show()

func disable_pickup():
	$"Pickup Sign".hide()

func _on_Box_body_entered(body):
	if body.is_in_group("player"):
		body.add_possible_pickup_item(self)

func _on_Box_body_exited(body):
	if body.is_in_group("player"):
		body.remove_possible_pickup_item(self)
