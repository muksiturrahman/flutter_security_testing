import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/**References:
Package name: flutter_secure_storage
Package url: https://pub.dev/packages/flutter_secure_storage
Version Used here: flutter_secure_storage: ^9.0.0
*/

class FlutterSecureStorageExample extends StatefulWidget {
  const FlutterSecureStorageExample({Key? key}) : super(key: key);

  @override
  State<FlutterSecureStorageExample> createState() => _FlutterSecureStorageExampleState();
}

class _FlutterSecureStorageExampleState extends State<FlutterSecureStorageExample> {
  String name = 'Zakir Bai';
  String email = 'zakir@gmail.com';
  int phone = 01734128544;
  bool isWorking = false;
  List<String> address = [
    "Permanent Address : Barbarian",
    "Present Address : Orange"
  ];

  // Create storage
  final storage = const FlutterSecureStorage();

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
    await storage.write(key: 'is_working', value: isWorking.toString());

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

  Future<Map<String, dynamic>> readAllStoredData() async {
    Map<String, dynamic> variables = {};

    // Read name and email
    variables['name'] = await storage.read(key: 'name');
    variables['email'] = await storage.read(key: 'email');

    // Read bool value
    variables['is_working'] = await storage.read(key: 'is_working');

    // Read int value
    variables['phone'] = await storage.read(key: 'phone');

    // Read list of String values
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
    variables['addresses'] = addresses;

    return variables;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is the example of Flutter Secure Storage'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: initBuildUi(),
      ),
    );
  }

  Widget initBuildUi() {
    return FutureBuilder(
      future: readAllStoredData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
          ); // Show loading indicator while data is being fetched
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          Map<String, dynamic> variables = snapshot.data as Map<String, dynamic>;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name: ${variables['name']}'),
                Text('Email: ${variables['email']}'),
                Text('Is Working: ${variables['is_working']}'),
                Text('Phone: ${variables['phone']}'),
                Column(
                  children: (variables['addresses'] as List<String>)
                      .map((address) => Text(address))
                      .toList(),
                ),
              ],
            ),
          );
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
