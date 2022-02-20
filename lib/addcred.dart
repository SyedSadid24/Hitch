import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddCred extends StatefulWidget {
  const AddCred({Key? key}) : super(key: key);

  @override
  _AddCredState createState() => _AddCredState();
}

class _AddCredState extends State<AddCred> {
  final TextEditingController _web = TextEditingController();
  final TextEditingController _user = TextEditingController();
  final TextEditingController _passwd = TextEditingController();
  late Box<List> friendsbox;

  @override
  void initState() {
    super.initState();
    friendsbox = Hive.box<List>('creds');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            maxLength: 20,
            controller: _web,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.web,
                color: Colors.green,
              ),
              hintText: 'Website / App',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          TextField(
            maxLength: 20,
            controller: _user,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.green,
              ),
              hintText: 'User',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          TextField(
            maxLength: 20,
            controller: _passwd,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.green,
              ),
              hintText: 'Password',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.green, fixedSize: const Size(500, 30)),
            onPressed: () {
              List creds = [_web.text, _user.text, _passwd.text];
              friendsbox.add(creds);
              _web.clear();
              _user.clear();
              _passwd.clear();
            },
            child: const Text(
              'Save',
            ),
          ),
        ],
      ),
    );
  }
}
