extends DragableObject
class_name  MainMenuItem

var respawn = true;

func onRemoved():
	if(!respawn):
		return;
	var newObjetct = duplicate() as DragableObject;
	get_parent().add_child(newObjetct);
	newObjetct.itemName = itemName;
	newObjetct.initialPos = initialPos;
	newObjetct.position = initialPos;