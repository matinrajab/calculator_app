import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String buttonText;
  final buttonTapped;

  const MyButton({super.key,
    required this.color,
    required this.textColor,
    required this.buttonText,
    this.buttonTapped
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(50),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: buttonTapped,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
