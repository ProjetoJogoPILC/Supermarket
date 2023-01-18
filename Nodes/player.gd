extends KinematicBody2D


# Declare member variables here. Examples:
export var max_speed = 5
export var acceleration = 0.1
export var deacceleration = 0.5

const instanceBox = preload("res://Nodes/Box.tscn")
var speed = Vector2.ZERO
var overlapping_items = []
var iventory = []
var picked_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    picked_up = false
    movement()
    item_pick()
    if !picked_up:
        item_drop()


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


func _on_PickupRange_area_entered(area):
    if area.is_in_group("pickable"):
        overlapping_items.append(area)
        

func _on_PickupRange_area_exited(area):
    if area.is_in_group("pickable"):
        area.deselect()
        overlapping_items.erase(area)


func item_pick():
    if overlapping_items.size() != 0 and iventory.size() == 0:
        ##################################
        # Sorts item by distance to player to remove confusion
        # when selecting Items from the floor
        overlapping_items.sort_custom(self, "sortDescendingByDistance")
        var selected_item = overlapping_items.back()
        for item in overlapping_items:
            item.deselect()        
        selected_item.select()
        ##################################
        if Input.is_action_just_pressed("ui_accept") and selected_item.can_pick_up():
            iventory.append(selected_item.get_text())
            selected_item.queue_free()
            picked_up = true


func item_drop():
    if iventory.size() == 1 and Input.is_action_just_pressed("ui_accept"):
        var box = instanceBox.instance()
        box.set_text(iventory.pop_back())
        box.position = $Position2D.global_position
        var tree = get_node("../")
        tree.add_child(box)
        pass


func sortDescendingByDistance(a, b):
    var da = position.distance_to(a.position)
    var db = position.distance_to(b.position)
    if da > db:
        return true
    return false
