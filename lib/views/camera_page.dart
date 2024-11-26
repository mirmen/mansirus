// lib/views/camera_page.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:io';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CameraPage extends StatefulWidget {
  final Talker talker;

  const CameraPage({super.key, required this.talker});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture; // Измените на Future<void>?
  String recognizedText = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception('Камеры недоступны');
      }
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _controller!.initialize();
    } catch (e) {
      widget.talker.error('Ошибка инициализации камеры: $e');
      print('Ошибка инициализации камеры: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (_controller == null) {
              return Center(child: Text('Камера не инициализирована.'));
            }
            return Stack(
              children: [
                CameraPreview(_controller!),
                // Остальная часть вашего UI...
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
