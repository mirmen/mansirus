import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

/// Кастомная навигационная панель
class CustomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(
      items: [
        CustomNavigationBarItem(
          icon: const Icon(Icons.translate),
          title: const Text(''),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.school),
          title: const Text(''),
        ),
        CustomNavigationBarItem(
          icon: const Icon(Icons.settings),
          title: const Text(''),
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
      selectedColor: Colors.blue,
      unSelectedColor: Colors.grey,
    );
  }
}
