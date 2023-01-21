extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var drag_enabled = false

export(float, 0, 5, 0.2) var drag_force = 50.0
export(float, 0, 100, 0.2) var max_force = 50.0
export(Curve) var force_graph
var max_force_distance
var r

func _ready():
    max_force_distance = $InteractionArea/CollisionShape2D.shape.radius 
    r = $CollisionShape2D.shape.radius 

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT:
            drag_enabled = event.pressed
    
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and not event.pressed:
            drag_enabled = false

func _physics_process(delta):
    drag()
    atomic_forces()

func drag():
    if drag_enabled:
        var new_position = get_global_mouse_position()
        var d = new_position - global_position
        apply_central_impulse(d*drag_force)

func atomic_forces():
    var sigma_force = Vector2.ZERO
    var atoms = $InteractionArea.get_overlapping_bodies()
    for a in atoms:
        if not a.is_in_group("atom"):
            continue
        var force = 0
        var dist = self.global_position.distance_to(a.global_position)
        if dist > max_force_distance:
            continue
        force = max_force * force_graph.interpolate(dist / max_force_distance)
        var force_direction = (a.global_position - self.global_position)
        sigma_force += force * force_direction.normalized()
    apply_central_impulse(sigma_force)
