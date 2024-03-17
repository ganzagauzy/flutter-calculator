import 'package:calculator/pages/guest/completePage.dart';
import 'package:calculator/pages/guest/options.dart';
import 'package:calculator/pages/login.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestQuizPage extends StatefulWidget {
  const GuestQuizPage({super.key});

  @override
  State<GuestQuizPage> createState() => _Guestquizpage();
}

class _Guestquizpage extends State<GuestQuizPage> {
  // text controllers
  // final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    // _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // _confirmpasswordController.dispose();
    super.dispose();
  }

  // Future signup() async {
  //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: _emailController.text.trim(),
  //       password: _passwordController.text.trim());

  // }

  Future<void> signup() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Sign-up successful, you can do something here
      // print('Sign-up successful: ${userCredential.user?.email}');
      // Navigate to another page, show a success message, etc.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      // Handle sign-up errors
      // print('Error signing up: $e');
      // Show an error message, log the error, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing up: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter App"),
          backgroundColor: Colors.amber[800],
          actions: [
            // Add an IconButton to toggle theme

            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amber[800], // Set background color to amber
              ),
              child: Icon(Icons.logout), // Use icon instead of text
            )
          ],
        ),
        // backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Stack(
                    children: [
                      Container(
                        height: 240,
                        width: 390,
                        decoration: BoxDecoration(
                          color: Colors.amber[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Positioned(
                          bottom: 60,
                          left: 22,
                          child: Container(
                            height: 170,
                            width: 315,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 5,
                                      spreadRadius: 3,
                                      color: Colors.amber.withOpacity(.4))
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '05',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 20),
                                      ),
                                      Text(
                                        '07',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      'Question 3/10',
                                      style:
                                          TextStyle(color: Colors.amber[800]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('What is computer')
                                ],
                              ),
                            ),
                          )),
                      Positioned(
                        bottom: 210,
                        left: 140,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Text(
                              '15',
                              style: TextStyle(
                                color: Colors.amber[800],
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Options(option: 'option A'),
                Options(option: 'option B'),
                Options(option: 'option C'),
                Options(option: 'option D'),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Completed()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}
