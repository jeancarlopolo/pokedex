import 'package:flutter/material.dart';

// não pode ser enum porque usa construtor do ThemeData
class Themes {
  static final light = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff00ADB5),
      brightness: Brightness.light
    ),
  );
  static final dark = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff222831),
      brightness: Brightness.dark
    ),
  );
}
