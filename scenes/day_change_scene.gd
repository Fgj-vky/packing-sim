extends Control

@export var boxesLabel: Label
@export var boxScroreLabel: Label
@export var moneyEarnedLable: Label
@export var expensesLabel: Label
@export var savingsLabel: Label
@export var totalLabel: Label

@export var continueGroup: Control;
@export var bankruptLabel: Control;
@export var bankruptButton: Control;

@export_file var gameScene: String;
@export_file(var mainMenuScene: String;

func _ready():
	var moneyEarned = max(10 * ProgressController.boxScore, 0) as int;
	var total = ProgressController.money + moneyEarned - ProgressController.dailyExpenses;

	boxesLabel.text = str(ProgressController.boxes);
	if(ProgressController.boxes == 0):
		boxScroreLabel.text = "0";
	else:
		boxScroreLabel.text = str(max(ProgressController.boxScore / ProgressController.boxes, 0) as int);
	moneyEarnedLable.text = str(moneyEarned);
	expensesLabel.text = str(ProgressController.dailyExpenses);
	savingsLabel.text = str(ProgressController.money);
	totalLabel.text = str(total);

	if(total < 0):
		continueGroup.queue_free();
	else:
		bankruptLabel.queue_free();
		bankruptButton.queue_free();
	pass


func _on_resume_button_pressed():
	ProgressController.advanceDay()
	get_tree().change_scene_to_file(gameScene);
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().change_scene_to_file(mainMenuScene);
	pass # Replace with function body.
