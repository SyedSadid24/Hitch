import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final TextEditingController _passwd = TextEditingController();
  String error = 'Enter Password';
  Color errorcolor = Colors.green;
  bool secure = true;
  bool click = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: TextStyle(
                fontSize: 30,
                color: errorcolor,
                fontFamily: 'RussoOne',
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              obscureText: secure,
              maxLength: 20,
              controller: _passwd,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: InkWell(
                  onTap: () {
                    togglepasswd();
                  },
                  child: Icon(click ? Icons.visibility_off : Icons.visibility),
                ),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.green,
                ),
                hintText: 'Password',
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.green, fixedSize: const Size(500, 30)),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final String? passwd = prefs.getString('passwd');
                  if (_passwd.text == passwd) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                  } else {
                    setState(() {
                      error = 'Incorrect Password';
                      errorcolor = Colors.red;
                    });
                  }
                },
                child: const Text('GO'))
          ],
        ),
      ),
    );
  }

  void togglepasswd() {
    setState(
      () {
        click = !click;
        secure = !secure;
      },
    );
  }
}
