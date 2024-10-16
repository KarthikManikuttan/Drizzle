import 'package:flutter/material.dart';

const Color primaryBlueColor = Color(0xff1877F2);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: Color(0xffFFFFFF),
    primary: Color(0xff000E08),
    inversePrimary: Color(0xffFFFFFF),
    secondary: Color(0xFF424242),
    outline: Color(0xFF3F3F3F),
    inverseSurface: Color(0xFFE7E7E7),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: Color(0xff1E1E1E),
    primary: Color(0xffFFFFFF),
    inversePrimary: Color(0xff000E08),
    secondary: Color(0xffB9C1BE),
    outline: Color(0xffCDD1D0),
    inverseSurface: Color(0xff4E5255),
  ),
);
