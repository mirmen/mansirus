import 'repositories.dart';
import 'entities.dart';

/// Use Case для выполнения перевода
class TranslateText {
  final TranslationRepository repository;

  const TranslateText(this.repository);

  Future<TranslationEntity> execute(String text, String from, String to) {
    return repository.translate(text, from, to);
  }
}
