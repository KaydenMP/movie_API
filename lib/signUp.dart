import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class AppSignUp extends StatefulWidget {
  const AppSignUp({Key? key}) : super(key: key);

  @override
  State<AppSignUp> createState() => _AppSignUpState();
}

class _AppSignUpState extends State<AppSignUp> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  bool hidePw = false;
  void signIn() {
    if (form.currentState!.validate()) {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Form(
          key: form,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Create Account',
                  style: GoogleFonts.abel(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.people),
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                        hintText: 'Enter your email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'username is required';
                      } else {
                        return null;
                      }
                    }),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: name,
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
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: password,
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
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: confirmpassword,
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
                        label: const Text('Confirm Password'),
                        hintText: 'Re-enter your password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is required';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'password must have digits';
                      }
                      if (password.text != confirmpassword.text) {
                        return 'password does not match';
                      }
                      return null;
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final auth = FirebaseAuth.instance;

                      final data = await auth.createUserWithEmailAndPassword(
                          email: email.text, password: password.text);

                      print(data);
                      signIn();
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      } else if (e.code == 'invalid-email') {
                        print('Please enter a valid email');
                      }
                    } catch (e) {
                      print('xxxxxxxxxxxx');
                      print(e);
                    }
                  },
                  child: const Text('Sign Up')),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('Sign In'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
