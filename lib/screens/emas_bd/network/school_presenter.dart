import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/all_classes_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/class_details_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/online_offline_class_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/success_message_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/topic_list_model.dart';
import 'base_client.dart';
import 'school_service.dart';
import 'package:http/http.dart' as http;

Future<dynamic> initClassMaterialsInfo(BuildContext context, String userType, String userId, String schoolSlug, String? textbookLink, String? lectureLink,) async {
  String url = SchoolService.classMaterialUrl;

  Map body = {

  };

  if(textbookLink != ""){
    body['textbook_link'] = textbookLink;
  }

  if(lectureLink != ""){
    body['lecture_link'] = lectureLink;
  }


  Map<String, String> headerMap = {
    "usertype": userType,
    "userid": userId,
    "schoolslug": schoolSlug,
  };

  var response = await BaseClient().initPostWithHeader(url, body, headerMap);

  if (response != null) {
    try {
      ResponseMessageModel responseMessage =
      ResponseMessageModel.fromJson(json.decode(response));

      return responseMessage;
    } catch (e) {
      return initClassMaterialsInfo(context, userType, userId, schoolSlug, textbookLink, lectureLink,);
    }
  } else {
    return "Server Error";
  }
}

Future<dynamic> initSetUpStudentBio(BuildContext context, File? notePdf, String userType, String userId, String schoolSlug, String fileName) async {
  String url = SchoolService.classMaterialUrl;

  Map<String, String> headerMap = {
    "usertype": userType,
    "userid": userId,
    "schoolslug": schoolSlug,
  };

  Map<String, String> body = {

  };

  List<http.MultipartFile> files = [];

  try {
    files.add(http.MultipartFile(
      'note_pdf[]', // Field name on the server
      notePdf!.readAsBytes().asStream(), // File stream
      notePdf.lengthSync(), // File length in bytes
      filename: fileName,
    ));
  } catch (e) {
    print(e);
  }

  var response = await BaseClient()
      .initPostWithFilesMultipart(url, headerMap, body, files);

  try {
    if (response != null) {
      try {
        /* StudentProfileSettingModel studentProfileSettingModel =
          StudentProfileSettingModel.fromJson(json.decode(response));*/

        return 'Updated successfully';
      } catch (e) {
        print(e);
        return response;
      }
    } else {
      return response;
    }
  } catch (e) {
    print(e);
  }
}

Future<dynamic> initAllClassesInfo(BuildContext context, String userType, String userId, String schoolSlug) async {
  String url = SchoolService.allClassesUrl;

  Map<String, String> headerMap = {
    "usertype": userType,
    "userid": userId,
    "schoolslug": schoolSlug,
  };

  var response = await BaseClient().initGetWithHeader(url, headerMap);

  if (response != null) {
    try {
      // AllClassesModel allClassesModel =
      // AllClassesModel.fromJson(json.decode(response));
      List<AllClassesModel> allClassesModel = List<AllClassesModel>.from(json
          .decode(response)
          .map<AllClassesModel>((dynamic i) => AllClassesModel.fromJson(i)));

      return allClassesModel;
    } catch (e) {
      return initAllClassesInfo(context, userType, userId, schoolSlug);
    }
  } else {
    return "Server Error";
  }
}

Future<dynamic> initTopicListInfo(BuildContext context, String userType, String userId, String schoolSlug) async {
  String url = SchoolService.topicListUrl;

  Map<String, String> headerMap = {
    "usertype": userType,
    "userid": userId,
    "schoolslug": schoolSlug,
  };

  var response = await BaseClient().initGetWithHeader(url, headerMap);

  if (response != null) {
    try {
      TopicListModel topicListModel =
      TopicListModel.fromJson(json.decode(response));

      return topicListModel;
    } catch (e) {
      return initTopicListInfo(context, userType, userId, schoolSlug);
    }
  } else {
    return "Server Error";
  }
}

Future<dynamic> initClassDetailsInfo(BuildContext context, String userType, String userId, String schoolSlug) async {
  String url = SchoolService.classDetailsUrl;

  Map<String, String> headerMap = {
    "usertype": userType,
    "userid": userId,
    "schoolslug": schoolSlug,
  };

  var response = await BaseClient().initGetWithHeader(url, headerMap);

  if (response != null) {
    try {
      ClassDetailsModel classDetailsModel =
      ClassDetailsModel.fromJson(json.decode(response));

      return classDetailsModel;
    } catch (e) {
      return initClassDetailsInfo(context, userType, userId, schoolSlug);
    }
  } else {
    return "Server Error";
  }
}

Future<dynamic> initOnlineOfflineInfo(BuildContext context, String userType, String userId, String schoolSlug, String? joiningUrl, String? meetingId, String? password, String? topicName, String? description, String? previousTopic) async {
  String url = SchoolService.onlineOfflineClassUrl;

  Map<String, String> headerMap = {
    "usertype": userType,
    "userid": userId,
    "schoolslug": schoolSlug,
  };

  Map body = {
    'class_schedule_id' : "2",
    'medium' : "2",
    'previous_material' : "",
    'date' : "16-09-1999",
  };

  if(joiningUrl != ""){
    body['zoom_ur'] = joiningUrl;
  }

  if(meetingId != ""){
    body['zoom_id'] = meetingId;
  }
  if(password != ""){
    body['zoom_password'] = password;
  }

  if(topicName != ""){
    body['topic'] = topicName;
  }
  if(description != ""){
    body['description'] = description;
  }

  if(previousTopic != ""){
    body['tag_previous_topics'] = previousTopic;
  }

  var response = await BaseClient().initPostWithHeader(url, body, headerMap);

  if (response != null) {
    try {
      OnlineOfflineClassModel onlineOfflineClassModel =
      OnlineOfflineClassModel.fromJson(json.decode(response));

      return onlineOfflineClassModel;
    } catch (e) {
      return initTopicListInfo(context, userType, userId, schoolSlug);
    }
  } else {
    return "Server Error";
  }
}
