import 'package:flutter/material.dart';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const Color secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const Color backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static Color selectedNavBarColor = Colors.cyan[800]!;
  static const Color unselectedNavBarColor = Colors.black87;
}
