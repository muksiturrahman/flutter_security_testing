import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/all_classes_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/class_details_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/online_offline_class_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/topic_list_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/network/school_presenter.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  List<AllClassesModel> allClasses = [];
  List<OnlineOfflineClassModel> onlineOfflineClasses = [];
  List<TopicListDatum> topicList = [];
  List<ClassDetailsModel> classDetails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async{
                  await _callAllClassesApi();
                },
                child: const Text('All Classes Api'),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async{
                  await _callTopicListApi();
                },
                child: const Text('Topic List Api'),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async{
                  await _callClassDetailsApi();
                },
                child: const Text('Class Details Api'),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async{
                  await _callOnlineOfflineClassApi();
                },
                child: const Text('Online offLine Class Api'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _callAllClassesApi() async {
    try {
      List<AllClassesModel> allClassesModel = [];

      var allClassesInfo = await initAllClassesInfo(context, "employee", "fatema@teacher", "initial",);

      if (allClassesInfo is String) {
        //Error Message
      } else {
        // allClassesModel.add(allClassesInfo);
        allClassesModel.addAll(allClassesInfo);
        allClasses = allClassesInfo;
        setState(() {
          allClasses;
        });
      }

      if (kDebugMode) {
        print('');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _callOnlineOfflineClassApi() async {
    try {
      List<OnlineOfflineClassModel> onlineOfflineClassModel = [];

      var onlineOfflineClassInfo = await initOnlineOfflineInfo(context, "employee", "fatema@teacher", "initial", "joiningUrl", "meetingId", "password", "topicName", "description", "previousTopic");

      if (onlineOfflineClassInfo is String) {
        //Error Message
      } else {
        onlineOfflineClassModel.add(onlineOfflineClassInfo);
        onlineOfflineClasses.addAll(onlineOfflineClassModel);
        setState(() {
          onlineOfflineClasses;
        });
      }

      if (kDebugMode) {
        print('');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _callTopicListApi() async {
    try {
      List<TopicListModel> topicListModel = [];

      var topicListInfo = await initTopicListInfo(context, "employee", "fatema@teacher", "initial",);

      if (topicListInfo is String) {

      } else {
        topicListModel.add(topicListInfo);
        topicList.addAll(topicListModel.elementAt(0).data);

        setState(() {
          topicList;
        });
      }

      if (kDebugMode) {
        print('');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _callClassDetailsApi() async {
    try {
      List<ClassDetailsModel> classDetailsModel = [];

      var classDetailsInfo = await initClassDetailsInfo(context, "employee", "fatema@teacher", "initial",);

      if (classDetailsInfo is String) {
        //Error Message
      } else {
        classDetailsModel.add(classDetailsInfo);
        classDetails.addAll(classDetailsModel);

        setState(() {
          classDetails;
        });
      }

      if (kDebugMode) {
        print('');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
