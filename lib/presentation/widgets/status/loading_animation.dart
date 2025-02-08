// lib/views/widgets/loading_animation_widget.dart
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation.twistingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.twistingDots(
      leftDotColor: Colors.blue,
      rightDotColor: Colors.green,
      size: 35,
    ));
  }
}
