import 'entities.dart';

/// Интерфейс репозитория для работы с переводом
abstract class TranslationRepository {
  Future<TranslationEntity> translate(String text, String from, String to);
  Future<bool> checkApiAvailability(); // Проверка доступности API
}
