import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:number_game/models/number_model.dart';
import 'package:number_game/services/number_db.dart';

class NumberController extends GetxController {
  static NumberController get to => Get.put(NumberController());
  var numbers = <NumberModel>[].obs;
  var numberLength = 0.obs;
  int currentPosition = 0;
  String randNumber = '';
  int rightNumber = 0;
  int rightPosition = 0;
  var inputNumber = TextEditingController();
  String tempNumber = '';
  var isValid = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNumbers();
  }

  generateRandNumber() {
    int a, b, c, d;
    a = Random().nextInt(10);
    do {
      b = Random().nextInt(10);
    } while (b == a);
    do {
      c = Random().nextInt(10);
    } while (c == a || c == b);
    do {
      d = Random().nextInt(10);
    } while (d == a || d == b || d == c);
    randNumber = '$a$b$c$d';
  }

  findCurrentPosition() {
    for (var i = 0; i < 10; i++) {
      if (numbers[i].isShow == 0) {
        currentPosition = i;
        break;
      }
    }
  }

  loadNumbers() async {
    generateRandNumber();
    // sqflite
    var latestResponse = await NumberDB.getNumbers(randNumber);

    // getx
    numbers.assignAll(latestResponse);
    numberLength.value = numbers.length;
    findCurrentPosition();
  }

  countRightNumber(String number) {
    for (var i = 0; i < 4; i++) {
      if (numbers[0].correctNumber.contains(number[i])) rightNumber++;
    }
  }

  countRightPosition(String number) {
    if (numbers[0].correctNumber[0] == number[0]) rightPosition++;
    if (numbers[0].correctNumber[1] == number[1]) rightPosition++;
    if (numbers[0].correctNumber[2] == number[2]) rightPosition++;
    if (numbers[0].correctNumber[3] == number[3]) rightPosition++;
  }

  updateNumber(String number) async {
    rightPosition = 0;
    rightNumber = 0;
    countRightNumber(number);
    countRightPosition(number);
    NumberDB.updateNumber(NumberModel(
        id: numbers[currentPosition].id,
        numberA: int.parse(number[0]),
        numberB: int.parse(number[1]),
        numberC: int.parse(number[2]),
        numberD: int.parse(number[3]),
        rightNumber: rightNumber,
        rightPosition: rightPosition,
        isShow: 1,
        correctNumber: numbers[0].correctNumber));

    numbers[currentPosition] = NumberModel(
        id: numbers[currentPosition].id,
        numberA: int.parse(number[0]),
        numberB: int.parse(number[1]),
        numberC: int.parse(number[2]),
        numberD: int.parse(number[3]),
        rightNumber: rightNumber,
        rightPosition: rightPosition,
        isShow: 1,
        correctNumber: numbers[0].correctNumber);
    currentPosition++;
    inputNumber.clear();
    numbers.refresh();
  }

  resetNumbers() {
    NumberModel numberModel;
    generateRandNumber();
    for (var i = 0; i < 10; i++) {
      numberModel = NumberModel(
        id: i + 1,
        numberA: 0,
        numberB: 0,
        numberC: 0,
        numberD: 0,
        rightNumber: 0,
        rightPosition: 0,
        isShow: 0,
        correctNumber: randNumber,
      );
      NumberDB.updateNumber(numberModel);
      numbers[i] = numberModel;
    }
    numbers.refresh();
    rightNumber = rightPosition = currentPosition = 0;
  }

  acceptNewNumber(var value) {
    isValid.value = value;
  }

  rejectSameCharacter() {
    var tempText = inputNumber.text;
    bool sameCharacter = false;
    if (inputNumber.text.length > 1) {
      for (var i = 0; i < inputNumber.text.length - 1; i++) {
        if (tempText[i] == tempText[tempText.length - 1]) {
          inputNumber.text = tempText.substring(0, tempText.length - 1);
          inputNumber.selection = TextSelection.fromPosition(
            TextPosition(offset: inputNumber.text.length),
          );
          acceptNewNumber(2);
          sameCharacter = !sameCharacter;
        }
      }
    }
    if (!sameCharacter) {
      if (inputNumber.text.length == 4)
        acceptNewNumber(1);
      else
        acceptNewNumber(0);
    }
  }
}
