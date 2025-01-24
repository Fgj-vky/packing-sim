extends DragableObject
class_name DragableTool

func _process(delta):
	var pos = global_position
	shadowDecal.set_position(Vector3(pos.x, pos.y - 6, pos.z))
	if Input.is_action_pressed("rotate_tool_left"):
		targetRotation = targetRotation * Quaternion.from_euler(Vector3(0, 0.1, 0))
	if Input.is_action_pressed("rotate_tool_right"):
		targetRotation = targetRotation * Quaternion.from_euler(Vector3(0, -0.1, 0))
