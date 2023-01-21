extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const instanceAtom = preload("res://Nodes/Atom.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if Input.is_action_just_released("ui_accept"):
        spawn_atom(get_global_mouse_position())

func spawn_atom(at_position):
    var atom = instanceAtom.instance()
    atom.global_position = at_position
    self.add_child(atom)
