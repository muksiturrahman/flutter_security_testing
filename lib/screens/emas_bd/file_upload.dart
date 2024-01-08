import 'dart:io';

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
  String? selectedFilePath;
  int? selectedFileSize;
  bool uploading = false;
  String uploadStatus = "uploading...";
  bool uploadCompleted = false;
  String lectureQuery = "";
  String textbookQuery = "";
  FilePickerResult? result;
  double uploadProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 500,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Files", style: TextStyle(color: Color(0xff484848))),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
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
                              SnackBar(
                                content: Text("Textbook link added successfully"),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Textbook link is empty. Please add Textbook link first"),
                              ),
                            );
                          }
                        },
                        child: Image.asset("assets/icons/plus.png"),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
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
                              SnackBar(
                                content: Text("Lecture link added Successfully."),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Lecture link is empty. Please add lecture link first"),
                              ),
                            );
                          }
                        },
                        child: Image.asset("assets/icons/plus.png"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Add Notes", style: TextStyle(color: Color(0xff484848))),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      result = await FilePicker.platform
                          .pickFiles(type: FileType.any);

                      if (result != null) {
                        File selectedFile = File(result!.files.single.path!);
                        setState(() {
                          selectedFilePath = selectedFile.path;
                          selectedFileSize = selectedFile.lengthSync();
                        });
                      }
                      setState(() {
                        uploading = true;
                        uploadCompleted = false;
                        uploadStatus = "uploading...";
                      });

                      // Simulate file upload process (replace with actual logic)
                      await Future.delayed(Duration(seconds: 3));

                      setState(() {
                        uploading = false;
                        uploadCompleted = true;
                        uploadStatus = "uploaded";
                      });
                      if (result != null && result!.files.isNotEmpty) {
                        File selectedFile = File(result!.files.single.path!);

                        await _callFileUploadApi(selectedFile);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Color(0xff8054DC)),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          "+ Upload New",
                          style: TextStyle(color: Color(0xff8054DC), fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  result != null ?
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFBFBFB),
                      borderRadius:
                      BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // Custom AppBar
                          SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                  "assets/icons/pdf.png"),
                              SizedBox(
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
                                      Container(
                                        width: MediaQuery.of(context).size.width/ 1.7,
                                        child: Text(
                                          path.basename(
                                              selectedFilePath ??
                                                  ""),
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            result = null;
                                          });
                                          print(result);
                                        },
                                        child: Image.asset(
                                          "assets/icons/cross.png",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        formatFileSize(
                                            selectedFileSize ??
                                                0),
                                        style: TextStyle(
                                            color: Color(
                                                0xffA9ACB4),
                                            fontSize:
                                            10),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          uploadCompleted?
                                          Image.asset("assets/icons/tick.png"):
                                          Image.asset(
                                              "assets/icons/loading.png"),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            uploadStatus,
                                            style: TextStyle(
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
                          SizedBox(height: 10),
                          if (uploading || uploadCompleted)
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey,
                                color: Color(0xffD59A01),
                                value: uploadCompleted ? 1.0 : 0.5,
                                minHeight: 4.0,
                              ),
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                  ):Container(),
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

      print('');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _callFileUploadApi(File? notePdf) async {
    try {
      List<ResponseMessageModel> responseMessageModel = [];


      var classMaterialsInfo = await initSetUpStudentBio(context, notePdf, "employee", "fatema@teacher", "initial", path.basename(selectedFilePath ?? ""));

      if (classMaterialsInfo is String) {
        //Error Message
      } else {
        responseMessageModel.add(classMaterialsInfo);

      }

      print('');
    } catch (e) {
      print(e);
    }
  }
}
