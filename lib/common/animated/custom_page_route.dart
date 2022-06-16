import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRoute<T> {
  final Widget child;

  CustomPageRoute(this.child);

  @override
  // TODO: implement barrierColor
  Color? get barrierColor => Colors.black;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => "";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return AnimatedContainer(duration: transitionDuration, child: child);
  }

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => const Duration(seconds: 1);
}
