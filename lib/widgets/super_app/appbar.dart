import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar SuperAppAppBar () {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.black,
    leading: Container(),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/icons/envelope.svg',
          color: Colors.orange[400],
          height: 20,
          width: 20,
        ),
        color: Colors.orange[400],
      ),
      IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/icons/search_icon.svg',
          color: Colors.orange[400],
          height: 20,
          width: 20,
        ),
        color: Colors.orange[400],
      ),
    ],
    title: Container(
      child: Text(
        "TEST INDONESIA 5",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
    ),
  );
}
