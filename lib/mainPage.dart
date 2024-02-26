import 'package:calculator/main.dart';
import 'package:calculator/pages/home.dart';
import 'package:calculator/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MyHomePage(
              title: 'Flutter App',
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
