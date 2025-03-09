import 'package:flutter/services.dart';

import '../../domain/clipboard/services.dart';

/// Реализация для работы с буфером обмена на Flutter
class FlutterClipboardService implements ClipboardService {
  /// Копирование текста в буфер обмена
  /// [text] - текст для копирования
  @override
  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
