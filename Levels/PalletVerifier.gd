extends Node2D

const instancePallet = preload("res://Nodes/Pallet.tscn")
export var radius = 100
var boxes = []
var num_boxes = 0
export var challenge_type = ""
var boxes_are_ordered = false
var last_boxes_are_ordered = false
signal ordered


func _ready():
    if challenge_type == "":
        challenge_type = "text"
    num_boxes = get_children().size()
    boxes_are_ordered = false
    last_boxes_are_ordered = false


func _process(_delta):
    boxes.clear()
    for node in get_children():
        if node.is_in_group("pallet"):
            if node.has_box():
                boxes.append(node.get_box())

    if challenge_type == "text":
        text_challenge()

    if boxes_are_ordered and not last_boxes_are_ordered:
        emit_signal("ordered")
    last_boxes_are_ordered = boxes_are_ordered


func text_challenge():
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
        # First I move the box to a far away place, and then I delete them.
        # I'm Doing this because queue_free() is not called on this frame,
        # instead it's called on the next possible frame
        box.position += Vector2(1000, 1000);
        box.queue_free()
    boxes.clear()
    boxes_are_ordered = false


func _create_new_pallets():
    for node in get_children():
        if node.is_in_group("pallet"):
            node.queue_free()
    for i in range(num_boxes):
        var pos = radius * Vector2(cos(2*PI*i/num_boxes), sin(2*PI*i/num_boxes))
        var pallet = instancePallet.instance()
        pallet.position = global_position + pos
        pallet.set_text(str(i+1))
        self.add_child(pallet)


func _on_Level01_start_next_challenge(challenge, qtd_boxes):
    challenge_type = challenge
    num_boxes = qtd_boxes
    delete_boxes()
    _create_new_pallets()