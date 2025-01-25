extends Node3D

@export var gameController: GameController;

@export var minScaleX: float;
@export var maxScaleX: float;

@onready var hand: Node3D = $Hand;

var box: Box;

func _ready():
	gameController.new_box_created.connect(connectToNewBox)
	pass

func connectToNewBox(newBox: Box):
	if(box != null):
		box.fill_amount_changed.disconnect(fillAmountChanged);
	newBox.fill_amount_changed.connect(fillAmountChanged)
	box = newBox;

func fillAmountChanged(amount: float):
	if(box.animPlayer.is_playing()):
		return;
	var tween = hand.create_tween();
	tween.tween_property(hand, "position:z", lerp(minScaleX, maxScaleX, min(max(amount - 0.2, 0), 1.0)), 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	pass
