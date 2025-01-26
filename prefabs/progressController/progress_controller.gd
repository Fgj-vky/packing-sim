extends Node

var day: int = 0;
var boxes: int = 0;
var boxScore: float = 0;
var money: int = 0;
var dailyExpenses = 100;

var ui: UiController

func advanceDay():
	day+=1;
	money += max(10 * ProgressController.boxScore, 0);
	boxScore = 0;
	boxes = 0;

func processBox(box: Box, order: Array[String]):
	print(box.fillAmount)
	print("Box contains: " + String(", ").join(box.itemNames))

	var requiredItems = order.size();
	var fragileItems = box.fragileItems;
	var correctItems = 0;
	var errors: Array[String] = [];
	for item in order:
		if box.itemNames.find(item) >= 0:
			box.itemNames.erase(item);
			correctItems += 1;
	print("Correct items: " + str(correctItems) + "/" + str(requiredItems));
	print("Box has receipt: " + str(box.hasReceipt));
	print("Box stamps: " + str(box.stampCount));
	print("Box tapes: " + str(box.tapeCount));
	for item in fragileItems:
		print("Fragile item: " + item);

	boxes += 1;

	var score = 0
	if box.hasReceipt:
		score += 2;
	else:
		score -= 1;
		errors.append("No receipt");

	if box.stampCount >= 2:
		score += 2;
	else:
		score -= 1;
		errors.append("Less than 2 stamps");

	if box.tapeCount >= 4:
		score += 2;
	else:
		score -= 1;
		errors.append("Less than 4 pieces of tape");

	if correctItems == requiredItems:
		score += 4;
	else:
		score -= 2;
		errors.append("Incorrect items");

	if fragileItems.size() > 0:
		for item in fragileItems:
			score -= 1;
			errors.append("Fragile item not wrapped");

	boxScore += score;
	print("Score: " + str(score));
	ui.updateErrorDisplay(errors);
