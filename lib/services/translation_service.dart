import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talker/talker.dart';

// КЛАСС УСТАРЕВШИЙ И ИСПОЛЬЗУЕТСЯ ДЛЯ СОБСТВЕННОГО API, А НЕ API СОВМЕСТИТЕЛЬНОГО С ЮНИИИТ
/* class TranslationService {
  final String apiHealth = "http://10.8.1.12:8000/health";
  final String apiUrl = "http://10.8.1.12:8000/translate/";
  final Talker talker;

  TranslationService(this.talker);

  Future<String> translate(String text, String direction) async {
    try {
      final response = await http
          .post(
            Uri.parse(apiUrl + direction),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'text': text}),
          )
          .timeout(const Duration(seconds: 600));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        talker.info('Успешный перевод: $text -> ${data['translated_text']}');
        return data['translated_text'];
      } else {
        throw Exception('Не удалось перевести: ${response.statusCode}');
      }
    } catch (e) {
      talker.error('Ошибка перевода: $e');
      return 'Произошла ошибка при переводе. Пожалуйста, попробуйте еще раз позже.';
    }
  }

  Future<bool> checkApiAvailability() async {
    try {
      final response = await http
          .get(Uri.parse(apiHealth))
          .timeout(const Duration(seconds: 20));
      talker.info('API по адресу $apiUrl доступен');
      return response.statusCode == 200;
    } catch (e) {
      talker.error('API по адресу $apiUrl не доступен, ошибка: $e');
      return false;
    }
  }
} */

class TranslationService {
  final String apiBaseUrl = "http://91.198.71.199:7012";
  final Talker talker;

  TranslationService(this.talker);

  Future<String> translate(
      String text, String sourceLanguage, String targetLanguage) async {
    try {
      final response = await http
          .post(
            Uri.parse('$apiBaseUrl/translator'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'text': text,
              'sourceLanguage': sourceLanguage,
              'targetLanguage': targetLanguage,
            }),
          )
          .timeout(const Duration(seconds: 600));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final translatedText = data['translatedText'] as String;
        talker.info('Успешный перевод: $text -> $translatedText');

        return translatedText;
      } else {
        throw Exception('Не удалось перевести: ${response.statusCode}');
      }
    } catch (e) {
      talker.error('Ошибка перевода: $e');
      return 'Произошла ошибка при переводе. Пожалуйста, попробуйте еще раз позже.';
    }
  }

  Future<bool> checkApiAvailability() async {
    try {
      final response = await http
          .get(Uri.parse('$apiBaseUrl/healthcheck'))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          talker.info('API доступен (service)');
          return true;
        }
      }
      talker.warning('API не доступен: ${response.statusCode}');
      return false;
    } catch (e) {
      talker.error('Ошибка при проверке доступности API: $e');
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getAvailableTranslations() async {
    try {
      final response = await http
          .get(Uri.parse('$apiBaseUrl/translator/available-translations'))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        talker.info('Получены доступные направления перевода');
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception(
            'Не удалось получить доступные переводы: ${response.statusCode}');
      }
    } catch (e) {
      talker.error('Ошибка при получении доступных переводов: $e');
      return [];
    }
  }
}
