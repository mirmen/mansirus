import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CustomTalkerScreen extends StatelessWidget {
  final Talker talker;

  const CustomTalkerScreen({super.key, required this.talker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TalkerScreen(
        talker: talker,
        theme: TalkerScreenTheme(
          cardColor: Colors.grey[700]!,
          backgroundColor: Colors.grey[800]!,
          textColor: Colors.white,
          logColors: {
            TalkerLogType.info: Colors.blue,
            TalkerLogType.error: Colors.red,
            TalkerLogType.warning: Colors.yellow,
            TalkerLogType.critical: Colors.redAccent,
            // Добавьте другие типы логов и их цвета, если необходимо
          },
        ),
      ),
    );
  }
}
