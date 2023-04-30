import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class AnswerProvider extends  ChangeNotifier{
  String _answer = '';

  String get answer => _answer;

  set answer(String question){
    question = question.replaceAll('÷', '/');
    question = question.replaceAll('×', '*');

    Parser p = Parser();
    Expression exp = p.parse(question);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    _answer = eval.toString();
    notifyListeners();
  }
}