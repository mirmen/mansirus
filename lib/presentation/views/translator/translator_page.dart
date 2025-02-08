import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../domain/translation/repositories.dart';
import '../../../domain/clipboard/services.dart';
import '../../../domain/translation/errors.dart';
import '../../widgets/widgets.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final TextEditingController _inputController = TextEditingController();
  String _translatedText = '';
  bool _isLoading = false;
  bool _isInputCopied = false;
  bool _isOutputCopied = false;
  bool _isRussianToMansiysk = true;

  Future<void> _translate() async {
    final talker = context.read<Talker>();
    setState(() => _isLoading = true);
    try {
      final repo = context.read<TranslationRepository>();

      // Проверка доступности API
      final isApiAvailable = await repo.checkApiAvailability();
      if (!isApiAvailable) {
        throw Exception(TranslationErrors.apiUnavailable);
      }

      // Выполнение перевода
      final result = await repo.translate(
        _inputController.text,
        _isRussianToMansiysk ? 'ru' : 'mns',
        _isRussianToMansiysk ? 'mns' : 'ru',
      );
      setState(() => _translatedText = result.translatedText);
    } on SocketException catch (_) {
      _showErrorSnackbar(TranslationErrors.noInternet);
    } on Exception catch (e) {
      _showErrorSnackbar(e.toString());
    } catch (e, st) {
      talker.error('Неизвестная ошибка', e, st);
      _showErrorSnackbar(TranslationErrors.unknownError);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleGeneralError(Exception e) {
    if (e.toString().contains('SocketException')) {
      _showErrorSnackbar(TranslationErrors.noInternet);
    } else if (e.toString().contains('500')) {
      _showErrorSnackbar(TranslationErrors.serverError);
    } else {
      _showErrorSnackbar(e.toString());
    }
  }

  void _showErrorSnackbar(String message) {
    final cleanMessage = message.replaceAll('Exception: ', '');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(cleanMessage),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _copyToClipboard(String text, bool isOutput) async {
    final clipboard = context.read<ClipboardService>();
    await clipboard.copyToClipboard(text);
    setState(() => isOutput ? _isOutputCopied = true : _isInputCopied = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => isOutput ? _isOutputCopied = false : _isInputCopied = false);
  }

  void _swapLanguages() {
    setState(() {
      _isRussianToMansiysk = !_isRussianToMansiysk;
      final temp = _inputController.text;
      _inputController.text = _translatedText;
      _translatedText = temp;
    });
  }

  void _clearInput() {
    _inputController.clear();
    setState(() => _translatedText = '');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GradientText(
              text: 'Mansirus',
              fontSize: screenWidth * 0.07,
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GradientText(
                        text: _isRussianToMansiysk ? 'Русский' : 'Мансийский',
                        fontSize: screenWidth * 0.05,
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    constraints: BoxConstraints(maxHeight: screenHeight * 0.25),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: TextField(
                              controller: _inputController,
                              decoration: InputDecoration(
                                hintText: 'Введите текст',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04),
                              ),
                              style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isInputCopied ? Icons.check : Icons.copy,
                            color: Colors.grey,
                          ),
                          onPressed: () =>
                              _copyToClipboard(_inputController.text, false),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: _clearInput,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Divider(color: Colors.grey.withOpacity(0.5))),
                      AnimatedGradientIconButton(
                        icon: Icons.swap_calls,
                        size: 30,
                        onPressed: _swapLanguages,
                      ),
                      AnimatedGradientIconButton(
                        icon: Icons.keyboard,
                        size: 30,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => MansyKeyboard(
                              onCharacterSelected: (char) {
                                setState(() {
                                  _inputController.text += char;
                                  _inputController.selection =
                                      TextSelection.fromPosition(
                                    TextPosition(
                                        offset: _inputController.text.length),
                                  );
                                });
                              },
                            ),
                          );
                        },
                      ),
                      Expanded(
                          child: Divider(color: Colors.grey.withOpacity(0.5))),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GradientText(
                      text: _isRussianToMansiysk ? 'Мансийский' : 'Русский',
                      fontSize: screenWidth * 0.05,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    constraints: BoxConstraints(maxHeight: screenHeight * 0.25),
                    child: Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              _translatedText,
                              style: GoogleFonts.montserrat(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isOutputCopied ? Icons.check : Icons.copy,
                            color: Colors.grey,
                          ),
                          onPressed: () =>
                              _copyToClipboard(_translatedText, true),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () => setState(() => _translatedText = ''),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            GradientButton(
              text: _isLoading ? 'Загрузка...' : 'Перевести',
              onPressed: () => _isLoading ? null : _translate,
            ),
          ],
        ),
      ),
    );
  }
}
