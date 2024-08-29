import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../gen/assets.gen.dart';


class AppLoader extends StatefulWidget {
  final Duration rotationDuration;
  final double? height, width;

  // Constructor to allow setting the rotation duration
  const AppLoader(
      {super.key,
        this.rotationDuration = const Duration(seconds: 1),
        this.height,
        this.width});

  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.rotationDuration,
      // Use the duration passed from the parent widget
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        child: Image.asset(
          Assets.png.loader.path,
          height: widget.height ?? 60,
          width: widget.width ?? 60,
        ),
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _controller.value * 2.0 * math.pi,
            child: child,
          );
        },
      ),
    );
  }
}
