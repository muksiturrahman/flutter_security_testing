/*
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/test_screen.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ApiService? _apiService;
  String? _uploadProgress;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    _apiService = ApiService(dio);
  }

  Future<void> _uploadFile() async {
    final file = File("/path/to/file");
    final name = "my_file";
    final description = "This is my file";

    try {
      await _apiService!.uploadFile(
        file,
        name,
        description,
        onSendProgress: (sent, total) {
          setState(() {
            _uploadProgress = "${(sent / total) * 100}%";
          });
        },
      );
    } on Exception catch (e) {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text("Upload File"),
            ),
            if (_uploadProgress != null)
              Text("Upload Progress: $_uploadProgress"),
          ],
        ),
      ),
    );
  }
}
*/
