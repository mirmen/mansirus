// lib/views/settings_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansirus/view_models/translation_view_model.dart';
import 'package:provider/provider.dart';
import 'custom_talker_screen.dart';
import 'widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Информация о приложении',
            style: GoogleFonts.montserrat(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          InfoItem(
            title: 'Mansirus',
            subtitle:
                'Удобный инструмент для перевода и изучения мансийского языка. Сохраняя язык, сохраняем культуру!',
            icon: Icons.translate,
          ),
          InfoItem(
            title: 'Версия',
            subtitle:
                'Mansirus v0.2.0\nПросим обратить внимание, что эта версия экспериментальная и находится в стадии постоянной разработки.',
            icon: Icons.info,
            onTap: () {
              // Открытие CustomTalkerScreen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CustomTalkerScreen(
                    talker: Provider.of<TranslationViewModel>(context,
                            listen: false)
                        .talker,
                  ),
                ),
              );
            },
          ),
          InfoItem(
            title: 'Разработчик',
            subtitle:
                'Студент ХМТПК \nМельгазиев Э.Р (m1rmen)\nTelegram: @emlgzv',
            icon: Icons.person,
          ),
          InfoItem(
            title: 'API',
            subtitle:
                'Югорский НИИ информационных технологий (ЮНИИТ)\nhttps://unitt.ru',
            icon: Icons.api,
          ),
          InfoItem(
            title: 'Модель',
            subtitle: 'Модель машинного перевода nllb-200-3.3B-ru-mns-2.0.2.',
            icon: Icons.computer,
          ),
          InfoItem(
            title: 'Обратная связь',
            subtitle: 'emir.melgaziev@gmail.com',
            icon: Icons.email,
          ),
        ],
      ),
    );
  }
}
