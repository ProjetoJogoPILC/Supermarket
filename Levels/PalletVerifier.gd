extends Node2D


var boxes = []
var num_boxes = 0
var boxes_are_ordered = false


func _ready():
    num_boxes = get_children().size()
    boxes_are_ordered = false


func _process(delta):
    boxes = []
    for node in get_children():
        if node.is_in_group("pallet"):
            if node.has_box():
                boxes.append(node.get_box())
    if boxes.size() >= num_boxes and is_ordered_asc(boxes):
        boxes_are_ordered = true
    else:
        boxes_are_ordered = false


func is_ordered_asc(items):
    for i in range(items.size()-1):
        if items[i].get_text() > items[i+1].get_text():
            return false
    return true


func delete_boxes():
    for node in get_children():
        if node.is_in_group("pallet"):
            node.overlapping_items.clear()
    for box in boxes:
        box.position += Vector2(1000, 1000);
        box.queue_free()
    boxes.clear()
    boxes_are_ordered = false
