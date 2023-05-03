import 'package:calculator_app/constant/const.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.85, 0.0),
      child: IconButton(
        onPressed: (){
          calculatorC.delete();
        },
        icon: const Icon(
          Icons.backspace_outlined,
          color: Color(0xFF8f83d7),
        ),
      ),
    );
  }
}
