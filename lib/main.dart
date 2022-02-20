import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import 'loginpage.dart';
import 'auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory doc = await getApplicationDocumentsDirectory();
  Hive.init(doc.path);
  await Hive.openBox<List>('creds');
  runApp(const MaterialApp(
    home: Initial(),
  ));
}

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  initState() {
    super.initState();
    _checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 42, 204, 82),
        child: const Image(image: AssetImage('images/logo.png')),
      ),
    );
  }

  void _checklogin() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final prefs = await SharedPreferences.getInstance();
    final bool? islogged = prefs.getBool('logged');
    if (islogged == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Auth()));
    }
  }
}
