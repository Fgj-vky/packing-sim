extends RigidBody3D
class_name DragableObject

var highlighted: bool = false
var dragging: bool = false
var targetRotation = Vector3(0, 0, 0)

@onready var meshInstance = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass

func _integrate_forces(state: PhysicsDirectBodyState3D):
	if dragging:
		# Tween rotation to target rotation
		var currentRotation = self.global_transform.basis.get_euler()
		var difference = targetRotation - currentRotation
		var direction = difference.normalized()
		var distance = difference.length()
		var max_accelaration = 10
		var acceleration = direction * min(max_accelaration, distance)
		self.apply_torque_impulse(acceleration)



func _on_mouse_entered():
	if DragControllerNode.isFree:
		DragControllerNode.setHighlighted(self)
		highlighted = true
		var tween = get_tree().create_tween()
		tween.tween_property(meshInstance, "scale", Vector3(1.1, 1.1, 1.1), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)


func _on_mouse_exited():
	if highlighted:
		DragControllerNode.setHighlighted(null)
		highlighted = false
		var tween = get_tree().create_tween()
		tween.tween_property(meshInstance, "scale", Vector3(1, 1, 1), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
