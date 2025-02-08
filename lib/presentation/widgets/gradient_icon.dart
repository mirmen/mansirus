import 'package:flutter/material.dart';

class AnimatedGradientIconButton extends StatefulWidget {
  final IconData icon;
  final double size; // Размер иконки
  final VoidCallback onPressed; // Обработчик нажатия
  final bool enableAnimation; // Параметр для включения/выключения анимации

  const AnimatedGradientIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 50.0, // Значение по умолчанию
    this.enableAnimation = true, // Значение по умолчанию
  });

  @override
  _AnimatedGradientIconButtonState createState() =>
      _AnimatedGradientIconButtonState();
}

class _AnimatedGradientIconButtonState extends State<AnimatedGradientIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.enableAnimation) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );

      _rotationAnimation =
          Tween<double>(begin: 0.0, end: 0.5).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));

      _scaleAnimation =
          Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.enableAnimation) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handlePress() {
    if (widget.enableAnimation) {
      _controller.forward().then((_) {
        _controller.reverse();
      });
    }
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePress,
      child: widget.enableAnimation
          ? ScaleTransition(
              scale: _scaleAnimation,
              child: RotationTransition(
                turns: _rotationAnimation,
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [Colors.blue, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Icon(
                    widget.icon,
                    size: widget.size,
                    color: Colors.white, // Цвет иконки
                  ),
                ),
              ),
            )
          : ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.blue, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Icon(
                widget.icon,
                size: widget.size,
                color: Colors.white, // Цвет иконки
              ),
            ),
    );
  }
}
