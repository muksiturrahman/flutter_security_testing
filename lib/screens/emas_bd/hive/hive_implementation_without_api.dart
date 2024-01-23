import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_testing/screens/emas_bd/hive/hive_with_encryption/hive_with_encryption.dart';
import 'package:hive/hive.dart';

class HiveTestWithoutApi extends StatefulWidget {
  const HiveTestWithoutApi({Key? key}) : super(key: key);

  @override
  _HiveTestWithoutApiState createState() => _HiveTestWithoutApiState();
}

class _HiveTestWithoutApiState extends State<HiveTestWithoutApi> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hive Test Without API"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const Encrypt()));
              },
              child: Text("Encrypt"),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Save data to Hive
                    await _saveData();
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Retrieve data from Hive and show in UI
                    await _showData();
                  },
                  child: Text('Show'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Update data in Hive
                    await _updateData();
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Delete data from Hive
                    await _deleteData();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveData() async {
    final box = await Hive.openBox('myBox');
    await box.put('name', nameController.text);
    await box.put('email', emailController.text);
    nameController.clear();
    emailController.clear();
  }

  Future<void> _showData() async {
    final box = await Hive.openBox('myBox');
    final name = box.get('name', defaultValue: 'No Name');
    final email = box.get('email', defaultValue: 'No Email');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Data from Hive'),
          content: Text('Name: $name\nEmail: $email'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateData() async {
    final box = await Hive.openBox('myBox');
    if (box.containsKey('name')) {
      await box.put('name', 'Updated Name');
      // You can similarly update the email if needed
    }else if(box.containsKey('email')){
      await box.put('email', 'Updated email');
    }
  }

  Future<void> _deleteData() async {
    final box = await Hive.openBox('myBox');
    if (box.containsKey('name')) {
      await box.delete('name');
    }else if(box.containsKey('email')){
      await box.delete('email');
    }
  }
}
