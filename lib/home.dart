import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'showcreds.dart';
import 'addcred.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int nvbindex = 0;

  final tabs = [
    const Showcreds(),
    const AddCred(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Info',
                      style: TextStyle(color: Colors.green),
                    ),
                    content: const Text(
                        'Hello User,\nHitch is a multiplatform Password manager application which provides unlimited entries. This is a beta version of the app. Please contact for bug report or any feedback.'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await launch('https://www.instagram.com/_leviath_24');
                        },
                        child: const Text('Contact'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('cancel'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.info))
        ],
        centerTitle: true,
        title: const Text(
          'HITCH',
          style: TextStyle(
            fontFamily: 'RussoOne',
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: tabs[nvbindex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          fixedColor: Colors.white,
          selectedFontSize: 15,
          currentIndex: nvbindex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
                color: Colors.white,
              ),
              label: 'Add',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: 'Settings'),
          ],
          onTap: (index) {
            setState(() {
              nvbindex = index;
            });
          }),
    );
  }
}
