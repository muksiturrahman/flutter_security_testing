// References:
// Package name: flutter_secure_storage
// Package url: https://pub.dev/packages/flutter_secure_storage
// Version Used here: flutter_secure_storage: ^9.0.0

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageExample extends StatefulWidget {
  const FlutterSecureStorageExample({Key? key}) : super(key: key);

  @override
  State<FlutterSecureStorageExample> createState() => _FlutterSecureStorageExampleState();
}

class _FlutterSecureStorageExampleState extends State<FlutterSecureStorageExample> {
  String name = 'Zakir Bhai';
  String email = 'zakir@gmail.com';
  int phone = 01372798334;
  bool isWorking = true;
  List<String> address = [
    "Permanent Address : Baridhara",
    "Present Address : Orangebd"
  ];

  // Create storage
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // Call the async method from initState
    initStoreData();
  }

  Future<void> initStoreData() async {
    // Write name and email
    await storage.write(key: 'name', value: name);
    await storage.write(key: 'email', value: email);

    // Write bool value
    await storage.write(key: 'isWorking', value: isWorking.toString());

    // Write int value
    await storage.write(key: 'phone', value: phone.toString());

    // Write list of String values
    for (int i = 0; i < address.length; i++) {
      await storage.write(key: 'address_$i', value: address[i]);
    }

    // Trigger a rebuild to show the data
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is the example of Flutter Secure Storage'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: initBuildUi(),
      ),
    );
  }

  Widget initBuildUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Show name
          FutureBuilder(
            future: storage.read(key: 'name'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Name: ${snapshot.data}');
              } else {
                return Text('Loading...');
              }
            },
          ),
          // Show email
          FutureBuilder(
            future: storage.read(key: 'email'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Email: ${snapshot.data}');
              } else {
                return Text('Loading...');
              }
            },
          ),
          // Show isWorking (bool)
          FutureBuilder(
            future: storage.read(key: 'isWorking'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Is Working: ${snapshot.data}');
              } else {
                return Text('Loading...');
              }
            },
          ),
          // Show phone (int)
          FutureBuilder(
            future: storage.read(key: 'phone'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Phone: ${snapshot.data}');
              } else {
                return Text('Loading...');
              }
            },
          ),
          // Show address list
          FutureBuilder(
            future: _readAddress(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<String> addresses = snapshot.data as List<String>;
                return Column(
                  children: addresses
                      .map((address) => Text(address))
                      .toList(),
                );
              } else {
                return Text('Loading...');
              }
            },
          ),
        ],
      ),
    );
  }


  Future<List<String>> _readAddress() async {
    List<String> addresses = [];
    int index = 0;
    while (true) {
      String? address = await storage.read(key: 'address_$index');
      if (address == null) {
        break;
      }
      addresses.add(address);
      index++;
    }
    return addresses;
  }
}
