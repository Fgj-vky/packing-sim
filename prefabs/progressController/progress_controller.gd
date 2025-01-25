extends Node

var day: int = 0;
var boxes: int = 0;
var boxScore: float = 0;
var money: int = 0;
var dailyExpenses = 100;

func advanceDay():
    day+=1;
    money += max(10 * ProgressController.boxScore, 0);
    boxScore = 0;
    boxes = 0;

func processBox(box: Box):
    print(box.fillAmount)
    boxes += 1;
    if(box.fillAmount > 0):
        boxScore += box.fillPrecentage();
    else:
        boxScore -= 1;
    pass
