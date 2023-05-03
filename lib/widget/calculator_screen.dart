import 'package:calculator_app/constant/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Obx(() {
              calculatorC.question.value = calculatorC.question.replaceAll('/100', '%');
              calculatorC.question.value = calculatorC.question.replaceAll('/', '÷');
              calculatorC.question.value = calculatorC.question.replaceAll('*', '×');
              return Text(
                calculatorC.question.value,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              );
            }),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Obx(() => Text(
              calculatorC.answer.value,
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
