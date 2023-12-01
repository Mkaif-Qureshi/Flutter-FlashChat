import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/components/roundedButton.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: [
                // Your other widgets
                if (isLoading)
                  CircularProgressIndicator(), // Show CircularProgressIndicator conditionally
              ],
            ),
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              style: TextStyle(color: Colors.black),
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email.'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              style: TextStyle(color: Colors.black),
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password.'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
                color: Colors.blueAccent,
                title: 'Register',
                onPress: () async {
                  // print(email);
                  // print(password);
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    final UserCredential newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  } finally {
                    isLoading = false;
                  }
                })
          ],
        ),
      ),
    );
  }
}
