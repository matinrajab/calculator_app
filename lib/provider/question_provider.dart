import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier{
  String _question = '';

  String get question => _question;

  set question(String button){
    _question = button;
    notifyListeners();
  }
}