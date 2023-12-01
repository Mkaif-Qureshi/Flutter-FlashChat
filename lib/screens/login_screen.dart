import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/components/roundedButton.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              onChanged: (value) {
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
              onChanged: (value) {
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
              color: Colors.lightBlueAccent,
              title: 'Login',
              onPress: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  CircularProgressIndicator();
                  final UserCredential currentUser =
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                  if (currentUser != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {
                  print('ERRROR: $e');
                } finally {
                  setState(() {
                    isLoading =
                        false; // Reset loading state after login attempt
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
