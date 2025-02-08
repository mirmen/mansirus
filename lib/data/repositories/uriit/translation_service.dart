import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mansirus/data/models/translation_dto.dart';
import 'package:mansirus/domain/health/checker.dart';
import 'package:mansirus/domain/translation/repositories.dart';
import 'package:mansirus/domain/translation/entities.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../domain/translation/errors.dart';

/// Реализация репозитория для API ЮНИИТ
class UriitTranslationService implements TranslationRepository {
  final String baseUrl;
  final HealthChecker healthChecker;
  final Talker talker;

  const UriitTranslationService({
    required this.baseUrl,
    required this.healthChecker,
    required this.talker,
  });

  @override
  Future<TranslationEntity> translate(
      String text, String from, String to) async {
    talker.log('Начало перевода через ЮНИИТ: $text');
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/translator'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'text': text,
          'sourceLanguage': from,
          'targetLanguage': to,
        }),
      );
      talker.log('Ответ от ЮНИИТ: ${response.statusCode}');

      if (response.statusCode == 200) {
        final dto = TranslationDTO.fromJson(jsonDecode(response.body));
        talker.log('Успешный перевод: ${dto.translatedText}');
        return TranslationEntity(
          translatedText: dto.translatedText,
          sourceLanguage: from,
          targetLanguage: to,
        );
      } else if (response.statusCode >= 500) {
        throw Exception(TranslationErrors.serverError);
      } else {
        throw Exception('Ошибка ${response.statusCode}');
      }
    } on SocketException {
      throw SocketException(TranslationErrors.noInternet);
    } catch (e, st) {
      talker.handle(e, st, 'Ошибка в UriitTranslationService');
      rethrow;
    }
  }

  @override
  Future<bool> checkApiAvailability() async {
    talker.log('Проверка доступности API ЮНИИТ: $baseUrl');
    try {
      final isAvailable = await healthChecker.checkApiHealth();
      talker.log('API ЮНИИТ доступен: $isAvailable');
      return isAvailable;
    } on SocketException {
      throw SocketException(TranslationErrors.noInternet);
    } catch (e, st) {
      talker.handle(e, st, 'Ошибка проверки API ЮНИИТ');
      return false;
    }
  }
}
