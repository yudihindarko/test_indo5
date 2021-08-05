import 'package:flutter/material.dart';

class ButtonIntro extends StatelessWidget {
  final String label;
  final onPressed;
  final Color textColor;
  final Color? backgroundColor;

  ButtonIntro({
    this.label = '',
    this.onPressed,
    this.textColor = Colors.black,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    Color finalBackgroundColor = backgroundColor ?? Colors.orange.shade400;

    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          "$label",
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          padding:
              MaterialStateProperty.all(EdgeInsets.only(top: 15, bottom: 15)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return finalBackgroundColor.withOpacity(0.8);
              return finalBackgroundColor; // Use the component's default.
            },
          ),
        ),
      ),
    );
  }
}
