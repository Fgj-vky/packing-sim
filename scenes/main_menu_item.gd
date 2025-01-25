extends DragableObject

func onRemoved():
	var newObjetct = duplicate() as DragableObject;
	get_parent().add_child(newObjetct);
	newObjetct.initialPos = initialPos;
	newObjetct.position = initialPos;