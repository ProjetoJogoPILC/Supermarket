extends Node2D

export var pickedup = "" 

func store(item):
    pickedup = item
    
func pickup():
    var x = pickedup
    pickedup = null
    return x
    
func has_item():
    if pickedup == null:
        return false
    return true
