import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_security_testing/screens/flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double widthSize = 0.0;
  double heightSize = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthSize = MediaQuery.of(context).size.width;
    heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: initBuildUi(),
      ),
    );
  }

  Widget initBuildUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlutterSecureStorageExample()));
            },
            child: Text('Flutter Secure Storage'),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FlutterDotEnvExample()));
            },
            child: Text('Flutter Dotenv'),
          ),
        ],
      ),
    );
  }
}
