import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;


class AppLogin extends StatefulWidget {
  const AppLogin({Key? key}) : super(key: key);

  @override
  State<AppLogin> createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  bool hidePw = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: form,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Text(
                  'Welcome',
                  style: GoogleFonts.abel(fontSize: 30),
                ),
              ),
              const SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    // controller: name,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.people),
                        border: OutlineInputBorder(),
                        label: Text('Username'),
                        hintText: 'Enter your username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'username is required';
                      } else {
                        return null;
                      }
                    }),
              ),
              SizedBox(height: 35,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    // controller: password,
                    obscureText: !hidePw,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: (() {
                              setState(() {
                                hidePw = !hidePw;
                              });
                            }),
                            icon: Icon(
                              hidePw ? Icons.visibility_off : Icons.visibility,
                            )),
                        border: const OutlineInputBorder(),
                        label: const Text('Password'),
                        hintText: 'Enter your password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is required';
                      }
                      if (value.length <= 6) {
                        return 'must be at least 6 letters long';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'password must have digits';
                      }
                      return null;
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (form.currentState!.validate()) {
                      Navigator.pushNamed(context, '/second');
                    }
                  },
                  child: const Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}
