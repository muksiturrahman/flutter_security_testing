import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
/**
References:
Package name: flutter_dotenv
Package url: https://pub.dev/packages/flutter_dotenv/example
Version Used here: flutter_dotenv: ^5.1.0

Important Notes:
-have to create .env file in the root of the project
-have to introduce .env file  in pubspec.yaml as asset
-have to load dotenv.load() in the main function of the project
*/

class FlutterDotEnvExample extends StatefulWidget {
  const FlutterDotEnvExample({Key? key}) : super(key: key);

  @override
  State<FlutterDotEnvExample> createState() => _FlutterDotEnvExampleState();
}

class _FlutterDotEnvExampleState extends State<FlutterDotEnvExample> {

  bool boolValue = dotenv.env['BOOL_VALUE'] == 'true';
  int intValue = int.parse(dotenv.env['INT_VALUE']!);
  List<String> listValue = dotenv.env['LIST_VALUE']!.split(',');
  String stringValue = dotenv.env['STRING_VALUE']!;

  @override
  void initState() {
    super.initState();
    print("LIST_VALUE: $listValue",);
    print("INT_VALUE: $intValue",);
    print("BOOL_VALUE: $boolValue",);
    print("STRING_VALUE: $stringValue",);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is the example of Flutter Dotenv'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("BOOL_VALUE: $boolValue",), //this is the way to use dotenv bool variables
              Text("INT_VALUE: $intValue",), //this is the way to use dotenv int variables
              Text("LIST_VALUE: $listValue",), //this is the way to use dotenv list variables
              Text("STRING_VALUE: $stringValue",), //this is the way to use dotenv string variables
              // Text('FOO: ${dotenv.env['FOO']}'),
              // Text('BAR: ${dotenv.env['BAR']}'),
              // Text('FOOBAR: ${dotenv.env['FOOBAR']}'),
            ],
          ),
        ),
      ),
    );
  }
}
