extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var verify = true

# Called when the node enters the scene tree for the first time.
func _ready():
    $Control.unset_success()
    verify = true
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if $PalletVerifier.boxes_are_ordered and verify:
        $Timer.start(1)
        $Control.set_success()
        verify = false


func next_challenge():
    $Control.unset_success()
    $Spawner.spawn_boxes("text")
    $PalletVerifier.delete_boxes()
    verify = true
    print("Next challenge!")
    
func _on_Timer_timeout():
    next_challenge()
