import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

bool hidePassword = false;
final GlobalKey<FormState> form = GlobalKey<FormState>();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Form(
                key: form,
                child: ListView(children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Text(
                      'Welcome',
                      style: GoogleFonts.aBeeZee(fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                            return 'email is required';
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
                        obscureText: !hidePassword,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: (() {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                }),
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
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
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        try {
                          final auth = FirebaseAuth.instance;

                          final loginData = auth.signInWithEmailAndPassword(
                              email: email.text, password: password.text);
                          print(loginData);
                          Navigator.pushNamed(context, '/second');
                        } on FirebaseAuthException catch (e) {
                          print(">>>>>>>>>>----------");
                          print(e.code);
                          if (e.code == "wrong-password") {
                            print("Wrong Password");
                          } else if (e.code == "user-not-found") {
                            print("This email does not have an account.");
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('Login'))
                ]))));
  }
}
