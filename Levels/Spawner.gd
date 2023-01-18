extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var chars = "ABCDEFGHIJKLMNOPQRSTUV"
const instanceBox = preload("res://Nodes/Box.tscn")
var rng

func _ready():
    rng = RandomNumberGenerator.new()

func spawn_boxes(type):
    if type == "text":
        for point in get_children():
            if point is Position2D:
                var box = instanceBox.instance()
                box.set_text(get_random_char())
                box.position = point.global_position
                var tree = get_node("../")
                tree.add_child(box)
                        
func get_random_char():
    rng.randomize()
    var i = rng.randi_range(0, chars.length()-1)
    return chars[i]
