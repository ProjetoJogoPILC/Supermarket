extends KinematicBody2D


# Declare member variables here. Examples:
export var max_speed = 5
export var acceleration = 0.1
export var deacceleration = 0.5
var speed = Vector2.ZERO

export var item_queue = []
var iventorium = []

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement()
	if item_queue.size() != 0:
		pickup()
	if iventorium.size() != 0:
		drop_items()


func movement():
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0, -1);
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0, +1);
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0);
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(1, 0);
	
	if direction.length() != 0:
		speed = speed.linear_interpolate(direction * max_speed, acceleration/100)
	else:
		speed = speed.linear_interpolate(direction * max_speed, deacceleration/100)
	move_and_slide(speed)

func pickup():
	item_queue.sort_custom(self, "sort_by_distance")
	# Disable pickup 
	for item in item_queue:
		item.disable_pickup()
	item_queue.back().enable_pickup()
	if Input.is_action_just_pressed("ui_accept"):
		var item = item_queue.back()
		item.get_picked()
		iventorium.push_back(item)

func drop_items():
	if Input.is_action_just_pressed("ui_end"):
		var item = iventorium.pop_back()
		item.drop(self.position)

func sort_by_distance(a, b):
	var dist_a = a.position.distance_to(self.position)
	var dist_b = b.position.distance_to(self.position)
	if dist_a < dist_b:
		return true
	else:
		return false
	
func add_possible_pickup_item(item):
	item_queue.push_back(item)
	
func remove_possible_pickup_item(item):
	var i = item_queue.find(item)
	item_queue.remove(i)
	item.disable_pickup()
