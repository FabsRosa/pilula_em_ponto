import 'package:flutter/material.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  final BuildContext ctx;

  SlidePageRoute({
    required this.child,
    this.direction = AxisDirection.left,
    required this.ctx,
  }) : super(
         transitionDuration: const Duration(milliseconds: 300),
         reverseTransitionDuration: const Duration(milliseconds: 300),
         pageBuilder: (ctx, animation, secondaryAnimation) => child,
       );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Offset getBeginOffset() {
      switch (direction) {
        case AxisDirection.up:
          return const Offset(0, 1);
        case AxisDirection.down:
          return const Offset(0, -1);
        case AxisDirection.left:
          return const Offset(1, 0);
        case AxisDirection.right:
          return const Offset(-1, 0);
      }
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: getBeginOffset(),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
      child: child,
    );
  }
}
