// lib/views/widgets/custom_navigation_bar_widget.dart
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

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
          icon: Icon(Icons.translate, size: 30),
          title: Text(''),
        ),
        CustomNavigationBarItem(
            icon: Icon(Icons.camera_alt, size: 30), title: Text('')),
        CustomNavigationBarItem(
          icon: Icon(Icons.school, size: 30),
          title: Text(''),
        ),
        CustomNavigationBarItem(
          icon: Icon(Icons.settings, size: 30),
          title: Text(''),
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white.withOpacity(0.9),
      selectedColor: Colors.blue,
      unSelectedColor: Colors.grey.withOpacity(0.7),
      borderRadius: Radius.circular(0),
      elevation: 30,
    );
  }
}
