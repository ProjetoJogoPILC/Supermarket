extends Area2D

export var text = ""
var can_pick_up = true

# Called when the node enters the scene tree for the first time.
func _ready():
    can_pick_up = true
    $Label.text = text
    $Pickup.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
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


func can_pick_up():
    return can_pick_up;

func disable_pick():
    can_pick_up = false
    
func enable_pick():
    can_pick_up = true
