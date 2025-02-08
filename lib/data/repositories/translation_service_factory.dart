// lib/data/repositories/translation_service_factory.dart

import 'package:mansirus/domain/health/checker.dart';
import 'package:mansirus/domain/translation/repositories.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'custom/translation_service.dart';
import 'uriit/translation_service.dart';

/// Фабрика для создания сервисов
class TranslationServiceFactory {
  static TranslationRepository createService(
    String type,
    String baseUrl,
    HealthChecker healthChecker,
    Talker talker,
  ) {
    switch (type) {
      case 'custom':
        return CustomTranslationService(
          baseUrl: baseUrl,
          healthChecker: healthChecker,
          talker: talker,
        );
      case 'uriit':
        return UriitTranslationService(
          baseUrl: baseUrl,
          healthChecker: healthChecker,
          talker: talker,
        );
      default:
        throw Exception('Unknown service type: $type');
    }
  }
}
