import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansirus/config.dart';
import 'package:mansirus/presentation/views/talker/custom_talker_screen.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String _selectedApiType;
  late TextEditingController _apiUrlController;

  @override
  void initState() {
    super.initState();
    _selectedApiType = AppConfig.apiType;
    _apiUrlController = TextEditingController(text: AppConfig.apiUrl);
  }

  @override
  void dispose() {
    _apiUrlController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    AppConfig.apiType = _selectedApiType;
    AppConfig.apiUrl = _apiUrlController.text;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Настройки сохранены')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final talker = context.read<Talker>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Информация о приложении',
                style: GoogleFonts.montserrat(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Оригинальные InfoItem
              InfoItem(
                title: 'Mansirus',
                subtitle:
                    'Удобный инструмент для перевода и изучения мансийского языка. Сохраняя язык, сохраняем культуру!',
                icon: Icons.translate,
              ),
              InfoItem(
                title: 'Версия',
                subtitle:
                    'Mansirus v0.3.0\nПросим обратить внимание, что эта версия экспериментальная и находится в стадии постоянной разработки.',
                icon: Icons.info,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CustomTalkerScreen(talker: talker)),
                  );
                  // Действие при нажатии
                },
              ),

              InfoItem(
                title: 'Разработчик',
                subtitle:
                    'Melgaziev Emir R.\nTelegram: @emlgzv\n🌐 m1rmen.tech',
                icon: Icons.person,
              ),
              InfoItem(
                title: 'API',
                subtitle:
                    'Текущий сервис: ${_selectedApiType == 'custom' ? 'Собственный' : 'ЮНИИТ'}\nАдрес: ${_apiUrlController.text}',
                icon: Icons.api,
              ),
              InfoItem(
                title: 'Модель',
                subtitle:
                    'Модель машинного перевода nllb-200-3.3B-ru-mns-2.0.2 (ЮНИИТ)',
                icon: Icons.computer,
              ),
              InfoItem(
                title: 'Обратная связь',
                subtitle: 'github.com/mirmen/mansirus',
                icon: Icons.email,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Настройки API
              Text(
                'Настройки API',
                style: GoogleFonts.montserrat(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedApiType,
                      items: [
                        DropdownMenuItem(
                          value: 'custom',
                          child: Text(
                            'Собственный API',
                            style: GoogleFonts.montserrat(),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'uriit',
                          child: Text(
                            'API от ЮНИИТ',
                            style: GoogleFonts.montserrat(),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedApiType = value);
                        }
                      },
                      dropdownColor:
                          Colors.white, // Цвет фона выпадающего списка
                      icon: Icon(Icons.arrow_drop_down,
                          color: Colors.black), // Цвет иконки
                      decoration: InputDecoration(
                        labelText: 'Тип сервиса',
                        labelStyle: TextStyle(
                            color: Colors.black), // Цвет текста лейбла
                        filled: true,
                        fillColor: Colors.white, // Цвет фона поля
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.black87), // Цвет границы
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.black87,
                              width: 2), // Активная граница
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    TextFormField(
                      controller: _apiUrlController,
                      decoration: InputDecoration(
                        labelText: 'Адрес API',
                        labelStyle: TextStyle(
                            color: Colors.black), // Цвет текста лейбла
                        hintText: 'https://api.example.com',
                        filled: true,
                        fillColor: Colors.white, // Цвет фона
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.black), // Граница
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: Colors.black87,
                              width: 2), // Активная граница
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.save,
                              color: Colors.black87), // Цвет иконки
                          onPressed: _saveSettings,
                        ),
                      ),
                      style: GoogleFonts.montserrat(
                          color: Colors.black87), // Цвет текста
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.save_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Сохранить настройки',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white, // Цвет текста
                    ),
                  ),
                  onPressed: _saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Цвет фона
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
