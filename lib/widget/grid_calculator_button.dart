import 'package:calculator_app/constant/const.dart';
import 'package:calculator_app/widget/button.dart';
import 'package:flutter/material.dart';

class GridCalculatorButton extends StatelessWidget {
  const GridCalculatorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        itemCount: calculatorC.buttons.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          // clear button
          if(calculatorC.buttons[index] == 'C'){
            return MyButton(
                buttonTapped: (){
                  calculatorC.clear();
                },
                color: const Color(0xFF5e5d7d),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
          // opening bracket button
          else if(calculatorC.buttons[index] == '('){
            return MyButton(
                buttonTapped: (){
                  calculatorC.openingBracket();
                },
                color: const Color(0xFF5e5d7d),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
          // closing bracket button
          else if(calculatorC.buttons[index] == ')'){
            return MyButton(
                buttonTapped: (){
                  calculatorC.closingBracket();
                },
                color: const Color(0xFF5e5d7d),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
          // percent button
          else if(calculatorC.buttons[index] == '%'){
            return MyButton(
                buttonTapped: (){
                  calculatorC.percent(context);
                },
                color: const Color(0xFF464765),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
          // operator button
          else if(calculatorC.isOperator(calculatorC.buttons[index])){
            return MyButton(
                buttonTapped: (){
                  calculatorC.operation(calculatorC.buttons[index]);
                },
                color: const Color(0xFF8f83d7),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
          // coma button
          else if(calculatorC.buttons[index] == '.'){
            return MyButton(
                buttonTapped: (){
                  calculatorC.coma();
                },
                color: const Color(0xFF464765),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
          // equal button
          else if(calculatorC.buttons[index] == '='){
            return MyButton(
                buttonTapped: (){
                  calculatorC.equal(context);
                },
                color: const Color(0xFF8f83d7),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
          // number button
          else{
            return MyButton(
                buttonTapped: (){
                  calculatorC.numberButton(calculatorC.buttons[index]);
                },
                color: const Color(0xFF464765),
                textColor: Colors.white,
                buttonText: calculatorC.buttons[index]);
          }
        },
      ),
    );
  }
}
