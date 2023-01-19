extends Node2D

const instanceBox = preload("res://Nodes/Box.tscn")
onready var hud = get_node("Hud")
signal start_next_challenge(challenge_type, qtd_boxes)


func _ready():
    hud.unset_success()


func _process(_delta):
    pass


func spawn_box(text: String, position: Vector2):
    var box = instanceBox.instance()
    box.set_text(text)
    box.position = position
    self.add_child(box)


func next_challenge():
    hud.unset_success()
    emit_signal("start_next_challenge", "text", randi()%6+1)


func _on_PalletVerifier_ordered():
    hud.set_success()
    $Timer.start(1)


func _on_Timer_timeout(): # SIGNAL
    next_challenge()


func _on_Spawner_drop_box(text, position):
	spawn_box(text, position)
