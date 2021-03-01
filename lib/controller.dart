import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Controller with ChangeNotifier {
  int optionNumber = 1;
  String input;
  var randomReward = '';
  bool hasDecided = false;
  List<String> options = [];

  incrementOption() {
    optionNumber++;
    notifyListeners();
  }

  submitButton() {
    if (input != null) {
      options.add(input);
      input = null;
      incrementOption();
    } else if (input == null) {
      print('there are no options');
      return;
    } else {
      return;
    }
    notifyListeners();
  }

  decideButton() {
    if (options.isEmpty) {
      notifyListeners();
      return randomReward = 'There are no options dude';
    } else if (options != null) {
      var randomize = new Random();
      randomReward = options[randomize.nextInt(options.length)];
      print(randomReward);
      hasDecided = true;
      notifyListeners();
      return randomReward;
    }
  }

  resetButton() {
    optionNumber = 1;
    options.removeRange(0, options.length);
    randomReward = '';
    hasDecided = false;
    notifyListeners();
  }
}
