// lib/views/translator_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../view_models/translation_view_model.dart';
import 'widgets/mansi_keyboard.dart';
import 'widgets/widgets.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final TextEditingController _inputController = TextEditingController();
  bool _isInputCopied = false;
  bool _isOutputCopied = false;

  void _swapLanguages(TranslationViewModel viewModel) {
    viewModel.setTranslationDirection(!viewModel.isRussianToMansiysk);
    final temp = _inputController.text;
    _inputController.text = viewModel.translatedText;
    viewModel.translateText(temp);
  }

  void _clearInput() {
    Provider.of<TranslationViewModel>(context, listen: false).clearInputText();
    _inputController.clear();
  }

  Future<void> _copyToClipboard(String text, bool isOutput) async {
    await Clipboard.setData(ClipboardData(text: text));
    setState(() {
      if (isOutput) {
        _isOutputCopied = true;
      } else {
        _isInputCopied = true;
      }
    });

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      if (isOutput) {
        _isOutputCopied = false;
      } else {
        _isInputCopied = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final translationViewModel = Provider.of<TranslationViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GradientText(
          text: 'Mansirus',
          fontSize: screenWidth * 0.07,
        ),
        SizedBox(height: screenHeight * 0.02),
        Container(
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
                    text: translationViewModel.isRussianToMansiysk
                        ? 'Русский'
                        : 'Мансийский',
                    fontSize: screenWidth * 0.05,
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.25,
                ),
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
                              color: Colors.black),
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
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _clearInput();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  AnimatedGradientIconButton(
                    icon: Icons.swap_calls,
                    size: 30,
                    onPressed: () => _swapLanguages(translationViewModel),
                  ),
                  AnimatedGradientIconButton(
                    icon: Icons.keyboard,
                    size: 30,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MansyKeyboard(
                            onCharacterSelected: (char) {
                              setState(() {
                                _inputController.text +=
                                    char; // Добавляем символ в текстовое поле
                                _inputController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset: _inputController.text.length),
                                );
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Align(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  text: translationViewModel.isRussianToMansiysk
                      ? 'Мансийский'
                      : 'Русский',
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.25,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: translationViewModel.isLoading
                            ? LoadingAnimation.twistingDots()
                            : Text(
                                translationViewModel.translatedText,
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
                      onPressed: () => _copyToClipboard(
                          translationViewModel.translatedText, true),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _clearInput();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        GradientButton(
          text: translationViewModel.isLoading ? 'Загрузка...' : 'Перевести',
          onPressed: () {
            Provider.of<TranslationViewModel>(context, listen: false)
                .translateText(_inputController.text);
          },
        ),
      ],
    );
  }
}
