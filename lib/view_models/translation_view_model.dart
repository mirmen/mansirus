import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../services/translation_service.dart';

// КЛАСС УСТАРЕВШИЙ И ИСПОЛЬЗУЕТСЯ ДЛЯ СОБСТВЕННОГО API, А НЕ API СОВМЕСТИТЕЛЬНОГО С ЮНИИИТ
/*
class TranslationViewModel extends ChangeNotifier {
  final Talker talker = TalkerFlutter.init(); // Инициализация Talker
  late final TranslationService
      _translationService; // Используем late для отложенной инициализации
  String _translatedText = '';
  String _inputText = '';
  bool _isLoading = false;
  bool _isRussianToMansiysk = true;
  bool _isApiAvailable = true;

  TranslationViewModel() {
    _translationService =
        TranslationService(talker); // Инициализация в конструкторе
  }

  String get translatedText => _translatedText;
  String get inputText => _inputText; // Добавлен геттер для inputText
  bool get isLoading => _isLoading;
  bool get isRussianToMansiysk => _isRussianToMansiysk;
  bool get isApiAvailable => _isApiAvailable;

  void setTranslationDirection(bool isRussianToMansiysk) {
    _isRussianToMansiysk = isRussianToMansiysk;
    notifyListeners();
  }

  void clearInputText() {
    _inputText = '';
    _translatedText = ''; // Очистите переведенный текст, если это необходимо
    notifyListeners(); // Уведомите слушателей об изменении состояния
  }

  Future<void> checkApiAvailability() async {
    _isApiAvailable = await _translationService.checkApiAvailability();
    if (_isApiAvailable) {
      talker.info('API доступен.');
    } else {
      talker.error('API недоступен.');
    }
    notifyListeners();
  }

  Future<void> translateText(String text) async {
    if (text.isEmpty) {
      _translatedText = '';
      notifyListeners();
      return;
    }

    _inputText = text;
    _isLoading = true;
    notifyListeners();

    String direction = _isRussianToMansiysk ? "ru_to_mns" : "mns_to_ru";

    try {
      _translatedText = await _translationService.translate(text, direction);
      talker.info('Перевод выполнен: "$text" -> "$_translatedText"');
    } catch (e) {
      _translatedText = 'Ошибка при переводе: $e';
      talker.error('Ошибка при переводе: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} */

class TranslationViewModel extends ChangeNotifier {
  final Talker talker = TalkerFlutter.init();
  late final TranslationService _translationService;
  String _translatedText = '';
  String _inputText = '';
  bool _isLoading = false;
  bool _isRussianToMansiysk = true;
  bool _isApiAvailable = true;
  List<Map<String, dynamic>> _availableTranslations = [];

  TranslationViewModel() {
    _translationService = TranslationService(talker);
    _loadAvailableTranslations();
  }

  String get translatedText => _translatedText;
  String get inputText => _inputText;
  bool get isLoading => _isLoading;
  bool get isRussianToMansiysk => _isRussianToMansiysk;
  bool get isApiAvailable => _isApiAvailable;
  List<Map<String, dynamic>> get availableTranslations =>
      _availableTranslations;

  void setTranslationDirection(bool isRussianToMansiysk) {
    _isRussianToMansiysk = isRussianToMansiysk;
    notifyListeners();
  }

  void clearInputText() {
    _inputText = '';
    _translatedText = '';
    notifyListeners();
  }

  Future<void> checkApiAvailability() async {
    _isApiAvailable = await _translationService.checkApiAvailability();
    if (_isApiAvailable) {
      talker.info('API доступен. (viewmodel)');
    } else {
      talker.error('API недоступен. (viewmodel)');
    }
    notifyListeners();
  }

  Future<void> _loadAvailableTranslations() async {
    _availableTranslations =
        await _translationService.getAvailableTranslations();
    notifyListeners();
  }

  Future<void> translateText(String text) async {
    if (text.isEmpty) {
      _translatedText = '';
      notifyListeners();
      return;
    }

    _inputText = text;
    _isLoading = true;
    notifyListeners();

    String sourceLanguage = _isRussianToMansiysk ? "rus_Cyrl" : "mancy_Cyrl";
    String targetLanguage = _isRussianToMansiysk ? "mancy_Cyrl" : "rus_Cyrl";

    try {
      _translatedText = await _translationService.translate(
          text, sourceLanguage, targetLanguage);
      talker.info('Перевод выполнен: "$text" -> "$_translatedText"');
    } catch (e) {
      _translatedText = 'Ошибка при переводе: $e';
      talker.error('Ошибка при переводе: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
