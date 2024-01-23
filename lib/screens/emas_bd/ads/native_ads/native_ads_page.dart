import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/emas_bd/ads/native_ads/native_ads_without_getx.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'controller.dart';

class NativeAdsPage extends StatefulWidget {
  const NativeAdsPage({super.key});

  @override
  State<NativeAdsPage> createState() => _NativeAdsPageState();
}

class _NativeAdsPageState extends State<NativeAdsPage> {
  var myController = Get.put(MyController());

  @override
  void initState() {
    super.initState();
    myController.loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Native Ads With Getx",
              style: TextStyle(color: Colors.white),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>NativeAds()));
                },
              child: Text("Native Ads"),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Text("Hello"),
          // set your according
          Obx(() => Container(
            child: myController.isAdLoaded.value
                ? ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 100,
                  minHeight: 100,
                ),
                child: AdWidget(ad: myController.nativeAd!))
                : const SizedBox(),
          )),
        ],
      ),
    );
  }
}
