import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mansirus/domain/translation/repositories.dart';
import 'package:mansirus/presentation/views/translator/translator_page.dart';
import '../../widgets/widgets.dart';
import '../learning/learning_page.dart';
import '../settings/settings_page.dart';

// Главный экран приложения
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Проверка доступности API при старте
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TranslationRepository>().checkApiAvailability();
    });
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(),
      bottomNavigationBar: CustomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentIndex) {
      case 0:
        return const TranslatorPage();
      case 1:
        return const LearningPage();
      case 2:
        return const SettingsPage();
      default:
        return const TranslatorPage();
    }
  }
}
