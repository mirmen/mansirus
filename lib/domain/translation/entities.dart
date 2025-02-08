/// Сущность для представления перевода
class TranslationEntity {
  final String translatedText; // Переведенный текст
  final String sourceLanguage; // Язык источника
  final String targetLanguage; // Язык назначения

  const TranslationEntity({
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
  });
}
