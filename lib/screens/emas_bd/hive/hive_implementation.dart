import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/emas_bd/hive/hive_implementation_without_api.dart';
import 'package:flutter_security_testing/screens/emas_bd/hive/video_story_model.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTest extends StatefulWidget {
  const HiveTest({Key? key}) : super(key: key);

  @override
  State<HiveTest> createState() => _HiveTestState();
}

class _HiveTestState extends State<HiveTest> {
  late Dio dio;
  late Future<Box<VideoStoryModel>> videoBoxFuture;
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/6300978111";

  @override
  void initState() {
    super.initState();
    dio = Dio();

    // Start the asynchronous process to open Hive box
    videoBoxFuture = openHiveBox();
    initBannerAd();
  }

  initBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnit,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        },
      ),
      request: AdRequest(),
    );
    bannerAd.load();
  }
  Future<Box<VideoStoryModel>> openHiveBox() async {
    // Open or create a Hive box called 'videos'
    final box = await Hive.openBox<VideoStoryModel>('videos');

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      print('Device is offline. Cannot fetch data.');
    } else {
      await box.clear();
      print(box);
    }

    // If the box is empty, fetch data
    if (box.isEmpty) {
      await fetchData(box);
    }

    return box;
  }

  Future<void> fetchData(Box<VideoStoryModel> videoBox) async {
    try {
      final response =
      await dio.get('https://www.kalbela.com/json-feed/video/video-stories.json');
      final List<dynamic> responseData = response.data;

      for (var videoData in responseData) {
        final videoStoryModel = VideoStoryModel.fromJson(videoData);

        videoBox.add(videoStoryModel);
      }

      setState(() {});
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  Future<void> updateData(Box<VideoStoryModel> videoBox, int videoId) async {
    // Find the video with the specified ID
    final videoIndex = videoBox.values
        .toList()
        .indexWhere((video) => video.id == videoId);

    if (videoIndex != -1) {
      // Modify the video object (e.g., update the title)
      final videoToUpdate = videoBox.getAt(videoIndex);
      if (videoToUpdate != null) {
        videoToUpdate.videoTitle = 'Updated Title';
        // Add more fields to update as needed

        // Save the updated video back to Hive
        await videoBox.putAt(videoIndex, videoToUpdate);
        setState(() {});
      }
    }
  }

  Future<void> deleteData(Box<VideoStoryModel> videoBox, int videoId) async {
    // Find the video with the specified ID
    final videoIndex = videoBox.values
        .toList()
        .indexWhere((video) => video.id == videoId);

    if (videoIndex != -1) {
      // Delete the video from Hive
      await videoBox.deleteAt(videoIndex);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hive Test"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const HiveTestWithoutApi()));
              },
              child: Text("WithoutApi"),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FutureBuilder<Box<VideoStoryModel>>(
            future: videoBoxFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final videoBox = snapshot.data!;
                return ValueListenableBuilder(
                  valueListenable: videoBox.listenable(),
                  builder: (context, Box<VideoStoryModel> box, _) {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final video = box.getAt(index)!;
                        return ListTile(
                          leading: Text(video.id.toString()),
                          title: Text(video.videoTitle),
                          subtitle: Text(video.entryTime),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // Call the update function with the video ID
                                  updateData(videoBox, video.id);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  // Call the delete function with the video ID
                                  deleteData(videoBox, video.id);
                                },
                              ),
                            ],
                          ),
                          // Add more widgets to display other information as needed
                        );
                      },
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          isAdLoaded?
          Positioned(
            bottom: 0,
            right: 10,
            child: InkWell(
              onTap: ()async{
                await bannerAd.dispose();
                setState(() {
                  isAdLoaded = false;
                });
              },
              child: Icon(Icons.close,size: 15,),
            ),
          ):Container(),
        ],
      ),
      bottomNavigationBar: isAdLoaded
          ? SizedBox(
        height: bannerAd.size.height.toDouble(),
        width: bannerAd.size.width.toDouble(),
        child: AdWidget(ad: bannerAd),
      )
          : null,
    );
  }
}
