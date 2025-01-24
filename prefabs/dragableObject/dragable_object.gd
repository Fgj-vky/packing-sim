extends Node3D
class_name DragableObject

var highlighted: bool = false


@onready var meshInstance = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	pass



func _on_mouse_entered():
	if DragControllerNode.isFree:
		DragControllerNode.setHighlighted(self)
		highlighted = true
		var tween = get_tree().create_tween()
		tween.tween_property(meshInstance, "scale", Vector3(1.2, 1.2, 1.2), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)


func _on_mouse_exited():
	if highlighted:
		DragControllerNode.setHighlighted(null)
		highlighted = false
		var tween = get_tree().create_tween()
		tween.tween_property(meshInstance, "scale", Vector3(1, 1, 1), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
