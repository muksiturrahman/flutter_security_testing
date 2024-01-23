import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_security_testing/screens/emas_bd/network/school_presenter.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/success_message_model.dart';
import 'package:path/path.dart' as path;

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  String lectureQuery = "";
  String textbookQuery = "";

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
    userType = "employee";
    userId = "fatema@teacher";
    schoolSlug = "initial";
    selectedFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 500,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Files", style: TextStyle(color: Color(0xff484848))),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Center(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Add Textbook Links",
                              hintStyle: TextStyle(
                                color: Color(0xff959595),
                                fontSize: 13,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff484848), width: 0.5),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff484848), width: 0.5),
                              ),
                            ),
                            onChanged: (val){
                              textbookQuery = val;
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if(textbookQuery.isNotEmpty){
                            _callSchoolMaterialsApi(textbookQuery, "", "");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Textbook link added successfully"),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Textbook link is empty. Please add Textbook link first"),
                              ),
                            );
                          }
                        },
                        child: Image.asset("assets/icons/plus.png"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Center(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Add Lecture Links",
                              hintStyle: TextStyle(
                                color: Color(0xff959595),
                                fontSize: 13,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff484848), width: 0.5),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff484848), width: 0.5),
                              ),
                            ),
                            onChanged: (val){
                              lectureQuery = val;
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if(lectureQuery.isNotEmpty){
                            _callSchoolMaterialsApi("", lectureQuery, "");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Lecture link added Successfully."),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Lecture link is empty. Please add lecture link first"),
                              ),
                            );
                          }
                        },
                        child: Image.asset("assets/icons/plus.png"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text("Add Notes", style: TextStyle(color: Color(0xff484848))),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: pickFile,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: const Color(0xff8054DC)),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Center(
                        child: Text(
                          "+ Upload New",
                          style: TextStyle(color: Color(0xff8054DC), fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  selectedFile != null?
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffFBFBFB),
                      borderRadius:
                      BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // Custom AppBar
                          const SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                  "assets/icons/pdf.png",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width / 1.7,
                                        child: Text(
                                          path.basename(selectedFile!.path),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            selectedFile = null;
                                          });
                                        },
                                        child: Image.asset(
                                          "assets/icons/cross.png",
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        formatFileSize(selectedFile!.lengthSync()),
                                        style: const TextStyle(
                                          color: Color(0xffA9ACB4),
                                          fontSize: 10,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          progress * 100 == 100 ?
                                          Image.asset("assets/icons/tick.png"):
                                          Image.asset(
                                              "assets/icons/loading.png"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            progress * 100 == 100 ? "Uploaded" : "Uploading",
                                            style: const TextStyle(
                                                fontSize:
                                                12),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: LinearProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffD59A01)),
                                backgroundColor: Colors.grey,
                                // color: ,
                                value: progress,
                                minHeight: 4.0,
                              ),
                            )
                        ],
                      ),
                    ),
                  ):Container(),
                  const SizedBox(height: 10),
                  Text("Progress: ${(progress * 100).toStringAsFixed(2)}%"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String formatFileSize(int size) {
    if (size < 1024) {
      return '$size B';
    } else if (size < 1048576) {
      return '${(size / 1024).toStringAsFixed(2)} KB';
    } else if (size < 1073741824) {
      return '${(size / 1048576).toStringAsFixed(2)} MB';
    } else {
      return '${(size / 1073741824).toStringAsFixed(2)} GB';
    }
  }

  Future<void> _callSchoolMaterialsApi(String textbookLink, String lectureLink, String notePdf) async {
    try {
      List<ResponseMessageModel> responseMessageModel = [];


      var classMaterialsInfo = await initClassMaterialsInfo(context, "employee", "fatema@teacher", "initial", textbookLink, lectureLink,);

      if (classMaterialsInfo is String) {
        //Error Message
      } else {
        responseMessageModel.add(classMaterialsInfo);

      }

      // print('');
    } catch (e) {
      // print(e);
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
      if(selectedFile != null){
        await postApiCall();
      }else{
        // print("File is Empty");
      }
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
        'file': await MultipartFile.fromFile(selectedFile!.path),
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
            progress = total > 0 ? sent / total.toDouble() : 0.0;
          });
        },

      );

      // print("Upload Complete");
      // Handle the response here
    } catch (error) {
      // print(error.toString());
      // Handle errors here
    }
  }
}
