import 'dart:io';

import 'package:http/http.dart' as http;
import '../../../domain/translation/errors.dart';
import '../../../domain/health/checker.dart';

/// Реализация проверки доступности для кастомного API
class CustomHealthChecker implements HealthChecker {
  final String baseUrl;

  const CustomHealthChecker(this.baseUrl);

  @override
  Future<bool> checkApiHealth() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/health'));
      if (response.statusCode != 200) {
        throw Exception('API недоступен: ${response.statusCode}');
      }
      return true;
    } on SocketException {
      throw SocketException(TranslationErrors.noInternet);
    } catch (e) {
      throw Exception(TranslationErrors.unknownError);
    }
  }
}
