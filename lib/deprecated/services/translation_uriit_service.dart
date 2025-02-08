// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:talker/talker.dart';

// // ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО ВАЖНО
// // Этот класс используется для работы с API, предоставленным URIIT (ЮНИИИТ)
// // Если вы испольузете собственное API на Flask (Python), закомментируйте этот класс и используйте translation_custom_service.dart.

// class TranslationService {
//   final String apiBaseUrl = "http://91.198.71.199:7012";
//   final Talker talker;

//   TranslationService(this.talker);

//   Future<String> translate(
//       String text, String sourceLanguage, String targetLanguage) async {
//     try {
//       final response = await http
//           .post(
//             Uri.parse('$apiBaseUrl/translator'),
//             headers: {'Content-Type': 'application/json'},
//             body: jsonEncode({
//               'text': text,
//               'sourceLanguage': sourceLanguage,
//               'targetLanguage': targetLanguage,
//             }),
//           )
//           .timeout(const Duration(seconds: 600));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(utf8.decode(response.bodyBytes));
//         final translatedText = data['translatedText'] as String;
//         talker.info('Успешный перевод: $text -> $translatedText');

//         return translatedText;
//       } else {
//         throw Exception('Не удалось перевести: ${response.statusCode}');
//       }
//     } catch (e) {
//       talker.error('Ошибка перевода: $e');
//       return 'Произошла ошибка при переводе. Пожалуйста, попробуйте еще раз позже.';
//     }
//   }

//   Future<bool> checkApiAvailability() async {
//     try {
//       final response = await http
//           .get(Uri.parse('$apiBaseUrl/healthcheck'))
//           .timeout(const Duration(seconds: 20));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'ok') {
//           talker.info('API доступен (service)');
//           return true;
//         }
//       }
//       talker.warning('API не доступен: ${response.statusCode}');
//       return false;
//     } catch (e) {
//       talker.error('Ошибка при проверке доступности API: $e');
//       return false;
//     }
//   }

//   Future<List<Map<String, dynamic>>> getAvailableTranslations() async {
//     try {
//       final response = await http
//           .get(Uri.parse('$apiBaseUrl/translator/available-translations'))
//           .timeout(const Duration(seconds: 20));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         talker.info('Получены доступные направления перевода');
//         return data.cast<Map<String, dynamic>>();
//       } else {
//         throw Exception(
//             'Не удалось получить доступные переводы: ${response.statusCode}');
//       }
//     } catch (e) {
//       talker.error('Ошибка при получении доступных переводов: $e');
//       return [];
//     }
//   }
// }
