import 'package:calculator/main.dart';
import 'package:calculator/pages/guest/completePage.dart';
import 'package:calculator/pages/guest/quiz.dart';
import 'package:calculator/pages/guest/homeQuiz.dart';
import 'package:calculator/pages/home.dart';
import 'package:calculator/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ); // Show loading indicator while authentication state is being fetched
          }

          if (snapshot.hasError) {
            return Text(
                'Error: ${snapshot.error}'); // Show error message if there's an error
          }

          if (snapshot.hasData) {
            User? user = FirebaseAuth.instance.currentUser;
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  ); // Show loading indicator while fetching user data
                }

                if (userSnapshot.hasError) {
                  return Text(
                      'Error: ${userSnapshot.error}'); // Show error message if there's an error
                }

                if (userSnapshot.data != null) {
                  if (userSnapshot.data!.exists) {
                    if (userSnapshot.data!.get('role') == "guest") {
                      return InitialQuizPage();
                    } else {
                      return MyHomePage(title: 'Flutter App');
                    }
                  } else {
                    // return Text('Document does not exist on the database');
                    return MyHomePage(title: 'Flutter App');
                  }
                } else {
                  return Text('No user data available');
                }
              },
            );
          } else {
            return LoginPage(); // If user is not logged in, show the login page
          }
        },
      ),
    );
  }
}
