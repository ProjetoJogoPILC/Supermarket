extends Area2D

export var text = ""
var can_pick_up = true


func _ready():
    can_pick_up = true
    $Label.text = text
    $Pickup.hide()


func _process(delta):
    pass


func get_text():
    return $Label.text


func set_text(text_to_set):
    text = text_to_set
    $Label.text = text


func deselect():
    $Pickup.hide()


func select():
    $Pickup.show()


func get_can_pick_up():
    return can_pick_up;


func disable_pick():
    can_pick_up = false


func enable_pick():
    can_pick_up = true
