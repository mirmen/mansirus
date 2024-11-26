import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton(
      {super.key, required this.text, required this.onPressed});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true; // Начинаем анимацию при нажатии
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false; // Завершаем анимацию при отпускании
        });
        widget.onPressed.call(); // Safe call, only invokes if not null
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false; // Завершаем анимацию при отмене
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: MediaQuery.of(context).size.width * 0.65,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isPressed
                ? [Colors.green.withOpacity(0.7), Colors.blue.withOpacity(0.7)]
                : [Colors.blue, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        transform: Matrix4.identity()
          ..scale(_isPressed ? 0.95 : 1.0), // Эффект уменьшения
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
