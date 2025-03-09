import 'package:flutter/services.dart';

/// Интерфейс для работы с буфером обмена
abstract class ClipboardService {
  Future<void> copyToClipboard(String text);
}
