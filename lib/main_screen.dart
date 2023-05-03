import 'package:calculator_app/widget/calculator_screen.dart';
import 'package:calculator_app/widget/delete_button.dart';
import 'package:calculator_app/widget/grid_calculator_button.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF3e3f5d),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: CalculatorScreen(),
            ),
            Expanded(
              flex: 1,
              // delete button
              child: DeleteButton(),
            ),
            Expanded(
                flex: 11,
                child: GridCalculatorButton(),
            ),
          ],
        ),
      ),
    );
  }
}
