import 'package:flutter/material.dart';

class ButtonList extends StatelessWidget {
  //const buttonList({super.key});

  final color;
  final textColor;
  final String buttonOutput;
  final buttonTapped;
  final buttonHold;

  const ButtonList(
      {this.color,
      this.textColor,
      this.buttonOutput = "",
      this.buttonTapped,
      this.buttonHold});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: buttonHold,
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonOutput,
                style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
