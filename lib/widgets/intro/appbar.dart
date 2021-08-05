import 'package:flutter/material.dart';

AppBar IntroAppbar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.black,
    leading: BackButton(color: Colors.orange.shade400),
    actions: [],
    centerTitle: true,
    title: Text(
      "TEST INDONESIA 5",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
    ),
  );
}
