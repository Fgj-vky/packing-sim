extends Node3D

@onready var box: Box = $BoxS;

@export_file var gameScene: String;

func _ready():
	DragControllerNode.inGame = true;
	box.fill_amount_changed.connect(itemPutIntoBox);
	pass

func itemPutIntoBox(amount):
	if(box.itemsInTheBox.size() == 0):
		return;
	if(box.itemsInTheBox[0].name == "Start"):
		await box.close();
		var tween = box.create_tween();
		await tween.tween_property(box, "global_position", box.global_position - Vector3(15, 0,0), 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING).finished
		get_tree().change_scene_to_file(gameScene);
	else:
		await box.close();
		var tween = box.create_tween();
		await tween.tween_property(box, "global_position", box.global_position - Vector3(-15, 0,0), 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING).finished
		get_tree().quit();