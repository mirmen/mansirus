import 'package:flutter/material.dart';

/// Виджет для отображения ошибки API
class ApiErrorWidget extends StatelessWidget {
  const ApiErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 20),
          Text(
            'API недоступно',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Проверьте подключение к интернету'),
        ],
      ),
    );
  }
}
