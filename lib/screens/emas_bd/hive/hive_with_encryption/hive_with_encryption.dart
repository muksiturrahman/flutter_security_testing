import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_security_testing/screens/emas_bd/hive/hive_with_encryption/encryption_secure_storage.dart';

class Encrypt extends StatefulWidget {
  const Encrypt({Key? key}) : super(key: key);

  @override
  _EncryptState createState() => _EncryptState();
}

class _EncryptState extends State<Encrypt> {
  late String decryptedText;
  late String encryptedBytes;
  late String encryptedBase16;
  late String encryptedBase64;

  @override
  void initState() {
    super.initState();
    _encryptAndDecryptData();
  }

  void _encryptAndDecryptData() {
    const plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';

    final key = encrypt.Key.fromSecureRandom(32);
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    // final decrypted = encrypted;

    decryptedText = decrypted;
    encryptedBytes = encrypted.bytes.toString();
    encryptedBase16 = encrypted.base16;
    encryptedBase64 = encrypted.base64;

    print('Decrypted: $decrypted');
    print('Encrypted Bytes: ${encrypted.bytes}');
    print('Encrypted Base16: ${encrypted.base16}');
    print('Encrypted Base64: ${encrypted.base64}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Encrypt Library"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const HiveEncryptionSecureStorage()));
              },
              child: Text("HiveEncryption"),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Decrypted: $decryptedText'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Encrypted Bytes: $encryptedBytes'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Encrypted Base16: $encryptedBase16'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Encrypted Base64: $encryptedBase64'),
            ),
          ],
        ),
      ),
    );
  }
}
