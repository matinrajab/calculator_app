import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorController extends GetxController{
  final List<String> buttons = [
    'C', '(', ')', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '%', '0', '.', '=',
  ];
  final List<String> operator = ['÷', '×', '-', '+', '%'];
  final List<String> number = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  var question = ''.obs;
  var answer = ''.obs;

  void calculateEval() {
    question.value = question.replaceAll('÷', '/');
    question.value = question.replaceAll('×', '*');
    question.value = question.replaceAll('%', '/100');
    Parser p = Parser();
    Expression exp = p.parse(question.value);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer.value = eval.toString();
    if (answer.endsWith('.0')) {
      answer.value = answer.replaceAll('.0', '');
    }
  }

  void delete(){
    question.value = question.substring(0, question.value.length-1);
    if(containsOperator(question.value)){
      if(endsWithOperator(question.value) || question.endsWith('(')){
        answer.value = '';
      }else{
        calculateEval();
      }
    }else{
      answer.value = '';
    }
  }

  void clear(){
    question.value = '';
    answer.value = '';
  }

  void openingBracket(){
    if(endsWithNumber(question.value) || question.endsWith('%') || question.endsWith(')')){
      question.value += '×';
    }
    question.value += '(';
    answer.value = '';
  }

  void closingBracket(){
    question.value += ')';
    calculateEval();
  }

  void percent(context){
    if(question.value == '' || endsWithOperator(question.value) || question.endsWith('(') || question.endsWith('%')){
      showError(context, "naruh persen di situ biar apa?");
    }else{
      question.value += '%';
      calculateEval();
    }
  }

  void operation(String oper){
    if(question.value != ''){
      if(!((question.endsWith('(') || question.endsWith('(+') || question.endsWith('(-')) && (oper == '×' || oper == '÷'))){
        if(endsWithOperator(question.value)){
          question.value = question.substring(0, question.value.length-1);
        }
        question.value += oper;
        answer.value = '';
      }
    }
  }

  void coma(){
    if(question.value == '' || endsWithOperator(question.value) || question.endsWith('(')){
      question.value += '0.';
    }else if(question.endsWith(')') || question.endsWith('%')){
      question.value += '×0.';
    }else if(!(question.endsWith('.'))){
      question.value += '.';
    }
    if(containsOperator(question.value)){
      calculateEval();
    }
  }

  void equal(context){
    if(answer.value != ''){
      if(answer.value == 'Infinity' || answer.value == '-Infinity'){
        showError(context, "gabisa dibagi 0");
      }else{
        question.value = answer.value;
        answer.value = '';
      }
    }else{
      if(question.value != '' && (containsOperator(question.value) || question.contains('(') || question.contains(')') || question.contains('.'))){
        showError(context, "format tidak valid");
      }
    }
  }

  void numberButton(String numb){
    if(question.endsWith('%') || question.endsWith(')')){
      question.value += '×';
    }
    question.value += numb;
    if(containsOperator(question.value)){
      calculateEval();
    }
  }

  bool endsWithNumber(String question){
    for(int i = 0; i < number.length; i++){
      if(question.endsWith(number[i])){
        return true;
      }
    }
    return false;
  }

  bool isOperator(String x) {
    return (x == '÷' || x == '×' || x == '-' || x == '+')
        ? true
        : false;
  }

  bool endsWithOperator(String question){
    for(int i = 0; i < 4; i++){
      if(question.endsWith(operator[i])){
        return true;
      }
    }
    return false;
  }

  bool containsOperator(String question){
    for(int i = 0; i < operator.length; i++) {
      if(question.contains(operator[i])){
        return true;
      }
    }
    return false;
  }

  void showError(context, String message){
    final snackBar = SnackBar(
      content: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            color: const Color(0xFF5e5d7d),
            child: Text(message),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: const Duration(milliseconds: 3000),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}