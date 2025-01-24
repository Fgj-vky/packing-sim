extends VBoxContainer

@export var revealRate: float = 1;
var children: Array[Node];

var timer: float;

func _ready():
	children = get_children();
	for child in children:
		child.visible = false;
		pass
	timer = revealRate;
	pass

func _process(delta):
	timer -= delta;
	if(timer <= 0 && children.size() > 0):
		timer = revealRate;
		var child = children.pop_front() as Node;
		child.visible = true;
	pass
