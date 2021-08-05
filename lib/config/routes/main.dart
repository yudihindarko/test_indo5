import 'package:flutter/material.dart';
import 'package:test_indo5/views/intro/register.dart';
import 'package:test_indo5/views/intro/login.dart';
import 'package:test_indo5/views/super_app/home.dart';

Map<String, Widget Function(BuildContext)> mainRoutes = {
  "/": (context) => LoginScreen(),
  "/register": (context) => RegisterScreen(),
  "/superapp/home": (context) => SuperAppHomeScreen(),
};
