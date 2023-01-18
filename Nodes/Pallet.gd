extends Area2D

var overlapping_items = []

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_just_pressed("ui_end"):
        print(get_box().get_text())
    pass
    

func has_box():
    return overlapping_items.size() != 0

func get_box():
    return overlapping_items.front()


func _on_Pallet_area_entered(area):
    if area.is_in_group("pickable"):
        if overlapping_items.size() == 0:
            area.position = $Position2D.global_position
            overlapping_items.append(area)


func _on_Pallet_area_exited(area):
    if area.is_in_group("pickable"):
        overlapping_items.erase(area)
