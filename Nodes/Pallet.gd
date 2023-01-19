extends Area2D

export var text = "Text"
var overlapping_items = []

# Called when the node enters the scene tree for the first time.
func _ready():
    $Label.text = text
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func has_box():
    return overlapping_items.size() != 0


func get_box():
    return overlapping_items.front()


func set_text(string):
    self.text   = string
    $Label.text = string


func get_text():
    return $Label.text


func _on_Pallet_area_entered(area):
    if area.is_in_group("pickable"):
        if overlapping_items.size() == 0:
            area.position = $Position2D.global_position
            overlapping_items.append(area)


func _on_Pallet_area_exited(area):
    if area.is_in_group("pickable"):
        overlapping_items.erase(area)
