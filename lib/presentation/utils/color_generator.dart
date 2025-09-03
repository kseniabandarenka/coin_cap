import 'dart:math';
import 'package:flutter/material.dart';

class ColorGenerator {
  static Color generateColorFromSeed(int seed) {
    final random = Random(seed);
    final red = random.nextInt(256);
    final green = random.nextInt(256);
    final blue = random.nextInt(256);

    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
