import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../domain/translation/errors.dart';
import '../../../domain/health/checker.dart';

/// Реализация проверки доступности для API ЮНИИТ
class UriitHealthChecker implements HealthChecker {
  final String baseUrl;

  const UriitHealthChecker(this.baseUrl);

  @override
  Future<bool> checkApiHealth() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/healthcheck'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'ok';
      }
      return false;
    } on SocketException {
      throw SocketException(TranslationErrors.noInternet);
    } catch (e) {
      throw Exception(TranslationErrors.unknownError);
    }
  }
}
