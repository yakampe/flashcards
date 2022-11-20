import 'package:flutter/material.dart';

class CardProcessState extends ChangeNotifier {
  int _total = 0;
  int _count = 1;
  int _correctCount = 0;
  int _incorrectCount = 0;
  int get getCounter {
    return _count;
  }

  int get getCorrect {
    return _correctCount;
  }

  int get getIncorrect {
    return _incorrectCount;
  }

  int get getTotal {
    return _total;
  }


  void setTotal(int total) {
    _total = total;
    notifyListeners();
  }

  void incrementCounter() {
    _count += 1;
    notifyListeners();
  }

  void incrementCorrectCounter() {
    _correctCount += 1;
    notifyListeners();
  }

  void incrementIncorrectCounter() {
    _incorrectCount += 1;
    notifyListeners();
  }
}