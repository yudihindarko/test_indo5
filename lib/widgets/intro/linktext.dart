import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String text;
  final onTap;

  const LinkText({this.text = '', this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        "$text",
        style: TextStyle(
          color: Colors.orange[400],
          fontSize: 16,
        ),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
