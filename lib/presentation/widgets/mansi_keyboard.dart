// lib/views/mansy_keyboard.dart
import 'package:flutter/material.dart';

class MansyKeyboard extends StatelessWidget {
  final Function(String) onCharacterSelected;

  const MansyKeyboard({super.key, required this.onCharacterSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: GridView.count(
        crossAxisCount: 10,
        shrinkWrap: true,
        children: [
          _buildKey('А'),
          _buildKey('а'),
          _buildKey('А̄'),
          _buildKey('а̄'),
          _buildKey('Б'),
          _buildKey('б'),
          _buildKey('В'),
          _buildKey('в'),
          _buildKey('Г'),
          _buildKey('г'),
          _buildKey('Д'),
          _buildKey('д'),
          _buildKey('Е'),
          _buildKey('е'),
          _buildKey('Е̄'),
          _buildKey('е̄'),
          _buildKey('Ё'),
          _buildKey('ё'),
          _buildKey('Ё̄'),
          _buildKey('ё̄'),
          _buildKey('Ж'),
          _buildKey('ж'),
          _buildKey('З'),
          _buildKey('з'),
          _buildKey('И'),
          _buildKey('и'),
          _buildKey('Ӣ'),
          _buildKey('ӣ'),
          _buildKey('Й'),
          _buildKey('й'),
          _buildKey('К'),
          _buildKey('к'),
          _buildKey('Л'),
          _buildKey('л'),
          _buildKey('М'),
          _buildKey('м'),
          _buildKey('Н'),
          _buildKey('н'),
          _buildKey('Ӈ'),
          _buildKey('ӈ'),
          _buildKey('О'),
          _buildKey('о'),
          _buildKey('О̄'),
          _buildKey('о̄'),
          _buildKey('П'),
          _buildKey('п'),
          _buildKey('Р'),
          _buildKey('р'),
          _buildKey('С'),
          _buildKey('с'),
          _buildKey('Т'),
          _buildKey('т'),
          _buildKey('У'),
          _buildKey('у'),
          _buildKey('Ӯ'),
          _buildKey('ӯ'),
          _buildKey('Ф'),
          _buildKey('ф'),
          _buildKey('Х'),
          _buildKey('х'),
          _buildKey('Ц'),
          _buildKey('ц'),
          _buildKey('Ч'),
          _buildKey('ч'),
          _buildKey('Ш'),
          _buildKey('ш'),
          _buildKey('Щ'),
          _buildKey('щ'),
          _buildKey('Ъ'),
          _buildKey('ъ'),
          _buildKey('Ы'),
          _buildKey('ы'),
          _buildKey('Ы̄'),
          _buildKey('ы̄'),
          _buildKey('Ь'),
          _buildKey('ь'),
          _buildKey('Э'),
          _buildKey('э'),
          _buildKey('Э̄'),
          _buildKey('э̄'),
          _buildKey('Ю'),
          _buildKey('ю'),
          _buildKey('Ю̄'),
          _buildKey('ю̄'),
          _buildKey('Я'),
          _buildKey('я'),
          _buildKey('Я̄'),
          _buildKey('я̄'),
        ],
      ),
    );
  }

  Widget _buildKey(String char) {
    return GestureDetector(
      onTap: () => onCharacterSelected(char),
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            char,
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
