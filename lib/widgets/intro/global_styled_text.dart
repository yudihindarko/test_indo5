import 'package:flutter/material.dart';

class GlobalStyledText extends StatelessWidget {
  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final FontStyle fontStyle;
  final TextAlign textAlign;
  final int maxLines;

  const GlobalStyledText(
    this.data, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.fontStyle = FontStyle.normal,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
      ),
      maxLines: maxLines,
    );
  }
}
