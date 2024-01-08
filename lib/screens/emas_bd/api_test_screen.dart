import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/all_classes_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/class_details_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/models/topic_list_model.dart';
import 'package:flutter_security_testing/screens/emas_bd/network/school_presenter.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  List<AllClassesModel> allClasses = [];
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
                child: Text('All Classes Api'),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async{
                  await _callTopicListApi();
                },
                child: Text('Topic List Api'),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () async{
                  await _callClassDetailsApi();
                },
                child: Text('Class Details Api'),
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
        allClassesModel.add(allClassesInfo);
        allClasses.addAll(allClassesModel);

        setState(() {
          allClasses;
        });
      }

      print('');
    } catch (e) {
      print(e);
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

      print('');
    } catch (e) {
      print(e);
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

      print('');
    } catch (e) {
      print(e);
    }
  }
}
