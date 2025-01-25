extends Control

@export var boxesLabel: Label
@export var boxScroreLabel: Label
@export var moneyEarnedLable: Label
@export var expensesLabel: Label
@export var savingsLabel: Label
@export var totalLabel: Label

@export_file var gameScene: String;

func _ready():
	var moneyEarned = max(10 * ProgressController.boxScore, 0) as int;
	var total = ProgressController.money + moneyEarned - ProgressController.dailyExpenses;

	boxesLabel.text = str(ProgressController.boxes);
	boxScroreLabel.text = str(max(ProgressController.boxScore / ProgressController.boxes * 100, 0) as int) + "/100";
	moneyEarnedLable.text = str(moneyEarned);
	expensesLabel.text = str(ProgressController.dailyExpenses);
	savingsLabel.text = str(ProgressController.money);
	totalLabel.text = str(total);
	pass


func _on_resume_button_pressed():
	ProgressController.advanceDay()
	get_tree().change_scene_to_file(gameScene);
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit();
	pass # Replace with function body.
