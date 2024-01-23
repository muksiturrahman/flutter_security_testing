import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class PostCallDio extends StatefulWidget {
  const PostCallDio({Key? key}) : super(key: key);

  @override
  _PostCallDioState createState() => _PostCallDioState();
}

class _PostCallDioState extends State<PostCallDio> {
  late Dio dio;
  late String userType;
  late String userId;
  late String schoolSlug;
  late File? selectedFile;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    userType = "employee"; // Replace with your actual user type
    userId = "fatema@teacher"; // Replace with your actual user id
    schoolSlug = "initial"; // Replace with your actual school slug
    selectedFile = null;
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> postApiCall() async {
    try {
      if (selectedFile == null) {
        // Handle no file selected
        return;
      }

      FormData formData = FormData.fromMap({
        'usertype': userType,
        'userid': userId,
        'schoolslug': schoolSlug,
        'file': await MultipartFile.fromFile(selectedFile!.path!),
      });

      await dio.post(
        'https://initial.emasbd.com/api/college/employeepanel/class_materials/1',
        data: formData,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
          },
        ),
        onSendProgress: (int sent, int total) {
          setState(() {
            progress = sent / total;
          });
        },
      );

      print("Upload Complete");
      // Handle the response here
    } catch (error) {
      print(error.toString());
      // Handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio Post Api Call Test"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: Text("Pick a File"),
            ),
            SizedBox(height: 20),
            selectedFile != null
                ? Text("Selected File: ${selectedFile!.path}")
                : Text("No File Selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (selectedFile != null) {
                  await postApiCall();
                } else {
                  // Handle no file selected
                }
              },
              child: Text("Upload File"),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 10),
            Text("Progress: ${(progress * 100).toStringAsFixed(2)}%"),
          ],
        ),
      ),
    );
  }
}
