import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _passwd = TextEditingController();
  String name = '';

  @override
  void initState() {
    super.initState();
    setname();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Hi ' + name,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 40,
              fontFamily: 'RussoOne',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            maxLength: 20,
            controller: _name,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.green,
              ),
              hintText: 'Name',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.green, fixedSize: const Size(500, 30)),
            onPressed: () async {
              if (_name.text.length > 2) {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('name', _name.text);
                setState(() {
                  name = _name.text;
                });
                _name.clear();
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Error',
                      style: TextStyle(color: Colors.red),
                    ),
                    content:
                        const Text('Name must contains atleast 3 characters'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('ok'))
                    ],
                  ),
                );
              }
            },
            child: const Text('Change name'),
          ),
          const SizedBox(height: 20),
          TextField(
            maxLength: 20,
            controller: _passwd,
            keyboardType: TextInputType.visiblePassword,
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
              onPressed: () async {
                if (_passwd.text.length > 3) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('passwd', _passwd.text);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Success',
                        style: TextStyle(color: Colors.green),
                      ),
                      content: const Text('Password changed'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('ok'))
                      ],
                    ),
                  );
                  _passwd.clear();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      title: Text(
                        'Error',
                        style: TextStyle(color: Colors.red),
                      ),
                      content: Text('Password must have atleast 4 characters'),
                    ),
                  );
                }
              },
              child: const Text('Change password'))
        ],
      ),
    );
  }

  setname() async {
    final prefs = await SharedPreferences.getInstance();
    String? pname = prefs.getString('name');
    setState(() {
      name = pname!;
    });
  }
}
