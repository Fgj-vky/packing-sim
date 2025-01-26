extends DragableObject
class_name DragableTool

@onready var keyPromp = $KeyPrompt

func _process(delta):
	var pos = global_position
	shadowDecal.set_position(Vector3(pos.x, pos.y - 6, pos.z))
	if Input.is_action_pressed("rotate_tool_left"):
		targetRotation = targetRotation * Quaternion.from_euler(Vector3(0, 0.1, 0))
	if Input.is_action_pressed("rotate_tool_right"):
		targetRotation = targetRotation * Quaternion.from_euler(Vector3(0, -0.1, 0))
	if Input.is_action_just_pressed	("use_tool"):
		useTool()

	if(position.y < -20):
		onRemoved();
		queue_free();

func useTool():
	pass

func onRemoved():
	var newTool = duplicate() as DragableTool;
	get_parent().add_child(newTool);
	newTool.initialPos = initialPos;
	newTool.position = initialPos;

func pickUp():
	keyPromp.visible = true;
	super();
	pass
func release():
	keyPromp.visible = false;
	super();
	pass