extends Control

@export var boxesLabel: Label
@export var boxScroreLabel: Label
@export var moneyEarnedLable: Label
@export var expensesLabel: Label
@export var savingsLabel: Label
@export var totalLabel: Label

func _ready():
    var moneyEarned = max(10 * ProgressController.boxScore, 0);
    var total = ProgressController.money + moneyEarned - ProgressController.dailyExpenses;

    boxesLabel.text = str(ProgressController.boxes);
    boxScroreLabel.text = str((ProgressController.boxScore / ProgressController.boxes * 100) as int) + "/100";
    moneyEarnedLable.text = str(moneyEarned);
    expensesLabel.text = str(ProgressController.dailyExpenses);
    savingsLabel.text = str(ProgressController.money);
    totalLabel.text = str(total);
    pass