import 'package:flutter/material.dart';

showSnackBar(
  context, {
  Color? backgroundColor,
  @required String? text,
}) {
  var scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(text ?? ""),
      backgroundColor: backgroundColor,
    ),
  );
}

hideSnackBar(context) => ScaffoldMessenger.of(context).hideCurrentSnackBar();
