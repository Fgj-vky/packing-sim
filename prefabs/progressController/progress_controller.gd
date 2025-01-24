extends Node

var day: int = 0;
var boxScore: float = 0;
var money: int = 0;

func advanceDay():
    day+=1;
    money += boxScore * 10;
    boxScore = 0;

func processBox(box: Box):
    if(box.fillAmount > 0):
        boxScore += box.fillPrecentage();
    else:
        boxScore -= 1;
    pass
