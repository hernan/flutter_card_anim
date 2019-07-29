import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class CardTransition extends AnimatedWidget {
  const CardTransition({
    Key key,
    @required Animation<double> turns,
    this.child,
  }) : assert(turns != null),
      super(key: key, listenable: turns);

  /// The animation that controls the rotation of the child.
  /// If the current value of the turns animation is v, the child will be
  /// rotated v * 2 * pi radians before being painted.
  Animation<double> get turns => listenable;

  /// The alignment of the origin of the coordinate system around which the
  /// rotation occurs, relative to the size of the box.
  ///
  /// For example, to set the origin of the rotation to top right corner, use
  /// an alignment of (1.0, -1.0) or use [Alignment.topRight]
  final Alignment alignment = Alignment.center;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    double calc = (1 - turnsValue) * math.pi / 2.0;
    final Matrix4 transform = Matrix4.rotationY(calc);
    // print('> $turnsValue');
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
