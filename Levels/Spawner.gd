extends Node2D


const instanceBox = preload("res://Nodes/Box.tscn")
signal drop_box(text, position)
var chars = "ABCDEFGHIJKLMNOPQRSTUV"
var rng


func _ready():
    rng = RandomNumberGenerator.new()


func spawn_boxes(type, qtd):
    if type == "text":
        _text_challenge(qtd)


func _text_challenge(qtd):
    var i = 0
    for point in get_children():
        if point is Position2D and i < qtd:
            emit_signal("drop_box", _get_random_char(), point.global_position)
            i += 1


func _get_random_char():
    rng.randomize()
    var i = rng.randi_range(0, chars.length()-1)
    return chars[i]


func _on_Level01_start_next_challenge(challenge_type, qtd_boxes):
	spawn_boxes(challenge_type, qtd_boxes)
