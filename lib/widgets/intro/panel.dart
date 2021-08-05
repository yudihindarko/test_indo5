import 'package:flutter/material.dart';

class PanelIntro extends StatelessWidget {
  final List<Widget> children;
  final String? headingText;

  const PanelIntro({this.children = const [], this.headingText = ''});

  @override
  Widget build(BuildContext context) {
    final finalChildren = [...children];

    // If has heading, insert into the panel
    if (headingText != '')
      finalChildren.insert(
        0,
        Text(
          "$headingText",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Colors.grey.shade100.withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          // width: 300,
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: finalChildren,
          ),
        ),
      ),
    );
  }
}
