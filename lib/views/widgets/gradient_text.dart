import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize; // Новый параметр для размера текста

  const GradientText({
    super.key,
    required this.text,
    this.fontSize = 30.0, // Значение по умолчанию
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.blue, Colors.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: fontSize, // Используем переданный размер
          fontWeight: FontWeight.bold,
          color: Colors.white, // Устанавливаем цвет текста в белый
        ),
      ),
    );
  }
}
