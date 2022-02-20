import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _passwd = TextEditingController();
  bool secure = true;
  bool click = true;
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hitch',
                style: TextStyle(
                  fontFamily: 'RussoOne',
                  fontSize: 50,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 80),
              TextFormField(
                validator: (value) {
                  if (value!.isNotEmpty && value.length > 2) {
                    return null;
                  } else {
                    return 'Atleast 3 characters';
                  }
                },
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
              TextFormField(
                validator: (value) {
                  if (value!.isNotEmpty && value.length > 3) {
                    return null;
                  } else {
                    return 'Atleast 4 characters';
                  }
                },
                controller: _passwd,
                keyboardType: TextInputType.visiblePassword,
                obscureText: secure,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.green,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      togglepasswd();
                    },
                    child:
                        Icon(click ? Icons.visibility_off : Icons.visibility),
                  ),
                  hintText: 'Password',
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green, fixedSize: const Size(500, 30)),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final isvalidform = formkey.currentState!.validate();
                    if (isvalidform) {
                      await prefs.setBool('logged', true);
                      await prefs.setString('name', _name.text);
                      await prefs.setString('passwd', _passwd.text);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RussoOne',
                    ),
                  ))
            ],
          ),
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
