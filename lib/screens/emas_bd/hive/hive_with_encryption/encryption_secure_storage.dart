import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class HiveEncryptionSecureStorage extends StatefulWidget {
  const HiveEncryptionSecureStorage({super.key});

  @override
  State<HiveEncryptionSecureStorage> createState() => _HiveEncryptionSecureStorageState();
}

class _HiveEncryptionSecureStorageState extends State<HiveEncryptionSecureStorage> {
  @override
  void initState() {
    _hiveEncryption();
    super.initState();
  }

  void _hiveEncryption() async{
    Map<String, dynamic> variables = {};

    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    var containsEncryptionKey = await secureStorage.containsKey(key: 'encryptionKey');
    if (containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'encryptionKey', value: base64UrlEncode(key));
    }

    variables['key'] = await secureStorage.read(key: 'encryptionKey');
    var encryptionKey = base64Url.decode(variables['key']);

    print("This is Encryption Key : $encryptionKey");

    var encryptedBox = await Hive.openBox('encryptedBox', encryptionCipher: HiveAesCipher(encryptionKey));
    encryptedBox.put('secret', 'Hive is awesome');
    print('hive test ${encryptedBox.get('secret')}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive Encryption"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
