// lib/views/translator_home_page.dart
import 'package:flutter/material.dart';
import 'package:mansirus/views/camera_page.dart';
import 'package:provider/provider.dart';
import '../view_models/translation_view_model.dart';
import 'widgets/custom_navigation_bar.dart';
import 'translator_page.dart';
import 'learning_page.dart';
import 'settings_page.dart';

// lib/views/translator_home_page.dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TranslationViewModel>(context, listen: false)
          .checkApiAvailability();
    });
  }

  @override
  Widget build(BuildContext context) {
    final translationViewModel = Provider.of<TranslationViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: _buildCurrentPage(translationViewModel),
        ),
      ),
      bottomNavigationBar: CustomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildCurrentPage(TranslationViewModel translationViewModel) {
    switch (_currentIndex) {
      case 0:
        return TranslatorPage(); // Используем новый виджет TranslatorPage
      case 1:
        return CameraPage(
          talker: translationViewModel.talker,
        );
      case 2:
        return LearningPage(); // Предполагается, что этот виджет уже существует
      case 3:
        return SettingsPage(); // Предполагается, что этот виджет уже существует
      default:
        return TranslatorPage(); // По умолчанию возвращаем TranslatorPage
    }
  }
}
