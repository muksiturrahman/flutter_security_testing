import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_security_testing/screens/emas_bd/dio/post_api_call_using_dio.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ApiCallUsingDio extends StatefulWidget {
  const ApiCallUsingDio({Key? key}) : super(key: key);

  @override
  State<ApiCallUsingDio> createState() => _ApiCallUsingDioState();
}

class _ApiCallUsingDioState extends State<ApiCallUsingDio> {
  late Dio dio;
  late List<dynamic> videoList;
  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/6300978111";

  @override
  void initState() {
    super.initState();
    dio = Dio();
    videoList = [];
    fetchData();
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

  Future<void> fetchData() async {
    try {
      final response = await dio
          .get('https://www.kalbela.com/json-feed/video/video-stories.json');
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
      bottomNavigationBar: isAdLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : null,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dio Test Api Call"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => PostCallDio()));
              },
              child: Text("PostCallDio"),
            ),
          ],
        ),
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
