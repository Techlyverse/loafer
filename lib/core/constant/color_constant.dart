import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ColorConstant {
  const ColorConstant._();

  static const Gradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffC9ACE5),
      Color(0xff8D69E1),
    ],
  );
}
