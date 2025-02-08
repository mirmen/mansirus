//import 'dart:async';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:talker/talker.dart';


// ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО
// Этот класс используется для работы с собственным API, развернутым на Flask (Python). 
// Если вы используете API, предоставленное URIIT, оставьте класс закомментированным и используйте translation_uriit_service.dart.
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


/* class TranslationService {
  final String apiHealth = "http://0.0.0.0:8000/health";
  final String apiUrl = "http://0.0.0.0:8000/translate/";
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