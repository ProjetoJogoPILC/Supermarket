extends Control


func _ready():
    unset_success()


func set_success():
    $CanvasLayer/Sprite.show()


func unset_success():
    $CanvasLayer/Sprite.hide()
