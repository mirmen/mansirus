// lib/views/learning_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansirus/presentation/widgets/gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          padding: EdgeInsets.all(screenWidth * 0.04),
          //color: Colors.grey[100],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  text: 'Экстренные фразы',
                  fontSize: screenWidth * 0.07,
                ),
                _buildInfoItem(
                    'Пожалуйста, помогите мне, я очень благодарен за вашу помощь.',
                    'Пле̄с, нё̄туӈкве а̄нумн, ам нё̄тминэ̄н та̄нки нё̄тнэ ма̄гсыл яныгпатум.',
                    Icons.help),
                _buildInfoItem(
                    'Я не говорю на вашем языке,\nно я надеюсь, что мы сможем понять друг друга.',
                    'Ам та̄н ла̄тӈыл потыртаӈкве ат торгам, ос ам нахмаягум, ма̄н\nаквхатыглаӈкве ве̄рме̄в.',
                    Icons.language),
                _buildInfoItem(
                    'Я потерялся в лесу и не знаю, как вернуться.',
                    'Ам во̄рт о̄лнэ ма̄гсыл ос ювле хумус ат ва̄сам.',
                    Icons.forest),
                _buildInfoItem('Мне очень страшно, и я нуждаюсь в помощи.',
                    'Ам сака пӯмащакв, ос ам нё̄туӈкве э̄ри.', Icons.warning),
                _buildInfoItem(
                    'Вы можете показать мне дорогу к ближайшему поселку?',
                    'На̄н а̄нумн йильпи па̄вылн ма̄гсыл ювле ёмасэ̄н?',
                    Icons.directions),
                _buildInfoItem(
                    'Я ищу свою семью, они потерялись тоже.',
                    'Ам колта̄гумн во̄раян, та̄н ос ю̄нсхатыгласыт.',
                    Icons.family_restroom),
                SizedBox(height: screenHeight * 0.02),
                _buildSectionTitle('Обучающие статьи', screenWidth),
                _buildLinkItem(
                    'Самоучитель мансийского языка',
                    'https://nordvind.ucoz.net/library/Linguistics/teach-ys-books/mansi.pdf',
                    Icons.article),
                SizedBox(height: screenHeight * 0.02),
                _buildSectionTitle('Обучающие видео', screenWidth),
                _buildLinkItem(
                    'Обучающее видео 1',
                    'https://www.youtube.com/watch?v=G1AN4FMrbFc',
                    Icons.play_arrow),
                _buildLinkItem(
                    'Обучающее видео 2',
                    'https://www.youtube.com/watch?v=z7v1xJgBI7U',
                    Icons.play_arrow),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildInfoItem(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8), // Отступ между иконкой и заголовком
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Цвет заголовка
            ),
            textAlign: TextAlign.start, // Центрируем заголовок
          ),
          SizedBox(height: 4), // Отступ между заголовком и подзаголовком
          Text(
            subtitle,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.black54,
            ),
            maxLines: 2, // Ограничиваем количество строк
            overflow: TextOverflow.ellipsis, // Добавляем многоточие
          ),
        ],
      ),
    );
  }

  Widget _buildLinkItem(String title, String url, IconData icon) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
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
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
