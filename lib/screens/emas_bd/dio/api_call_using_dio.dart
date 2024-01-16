import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ApiCallUsingDio extends StatefulWidget {
  const ApiCallUsingDio({Key? key}) : super(key: key);

  @override
  State<ApiCallUsingDio> createState() => _ApiCallUsingDioState();
}

class _ApiCallUsingDioState extends State<ApiCallUsingDio> {
  late Dio dio;
  late List<dynamic> videoList;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    videoList = [];
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await dio.get('https://www.kalbela.com/json-feed/video/video-stories.json');
      setState(() {
        videoList = response.data;
      });
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio Test Api Call"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          // Customize this part based on your API response structure
          final video = videoList[index];
          return ListTile(
            // leading: Image.network(video['']),
            title: Text(video['video_title']),
            subtitle: Text(video['operator']),
            // Add more widgets to display other information as needed
          );
        },
      ),
    );
  }
}
