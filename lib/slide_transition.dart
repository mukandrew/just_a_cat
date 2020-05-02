import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

abstract class Slide {
  static SlideTransition enterOffsetX(
      Widget child, Animation<double> animation, bool reverse,
      {double fromX = 1.0}) {
    final from = reverse ? -fromX : fromX;
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(from, 0.0),
        end: Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

  static SlideTransition exitOffsetX(
      Widget child, Animation<double> animation, bool reverse,
      {double toX = -1.0}) {
    final to = reverse ? -toX : toX;
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(to, 0.0),
        end: Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}