import 'package:flutter/material.dart';

class NativeAds extends StatefulWidget {
  const NativeAds({super.key});

  @override
  State<NativeAds> createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NativeAds"),
      ),
    );
  }
}
