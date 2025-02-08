/// DTO для ответа API перевода
class TranslationDTO {
  final String translatedText;

  TranslationDTO({required this.translatedText});

  factory TranslationDTO.fromJson(Map<String, dynamic> json) {
    return TranslationDTO(translatedText: json['translated_text']);
  }
}
