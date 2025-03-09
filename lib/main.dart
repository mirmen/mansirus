import 'package:flutter/material.dart';
import 'package:mansirus/data/repositories/clipboard_service.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'config.dart';
import 'data/repositories/translation_service_factory.dart';
import 'domain/clipboard/services.dart';
import 'domain/health/checker.dart';
import 'data/repositories/custom/custom_checker.dart';
import 'data/repositories/uriit/uriit_checker.dart';
import 'domain/translation/repositories.dart';
import 'presentation/views/home/home_page.dart';

final talker = TalkerFlutter.init();
void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Talker>(create: (_) => talker),
        Provider<HealthChecker>(
          create: (_) => AppConfig.apiType == 'custom'
              ? CustomHealthChecker(AppConfig.apiUrl)
              : UriitHealthChecker(AppConfig.apiUrl),
        ),
        Provider<TranslationRepository>(
          create: (context) => TranslationServiceFactory.createService(
            AppConfig.apiType,
            AppConfig.apiUrl,
            context.read<HealthChecker>(), // Передаем healthChecker
            context.read<Talker>(), // Передаем Talker
          ),
        ),
        Provider<ClipboardService>(
          create: (_) => FlutterClipboardService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mansirus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
