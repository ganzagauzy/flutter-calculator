import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:calculator/pages/guest/completePage.dart';
import 'package:calculator/pages/guest/homeQuiz.dart';
import 'package:calculator/pages/guest/options.dart';
import 'package:calculator/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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

  List responseData = [];
  int number = 0;
  List<String> shuffleOptions = [];
  late Timer _timer;
  int _secondsRemaining = 15;

  @override
  void dispose() {
    // _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // _confirmpasswordController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('quizes').get();

      List<Map<String, dynamic>> dataList = [];

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        dataList.add(data);
      });
      print('list: $dataList');
      return dataList;
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
      return [];
    }
  }

  Future api() async {
    final response =
        await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['results'];
      setState(() {
        responseData = data;
        updateShufleOption();
        startTimer();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    api();
    fetchDataFromFirestore();
    // startTimer();
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
                                        (number + 1).toString(),
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 20),
                                      )
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      'Question ${number + 1}/10',
                                      style:
                                          TextStyle(color: Colors.amber[800]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(responseData.isNotEmpty
                                      ? responseData[number]['question']
                                      : '')
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
                              _secondsRemaining.toString(),
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
                Column(
                  children: (responseData.isNotEmpty &&
                          responseData[number]['incorrect_answers'] != null)
                      ? shuffleOptions.map((option) {
                          return Options(option: option.toString());
                        }).toList()
                      : [],
                ),
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
                      nextQuestion();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Completed()),
                      // );
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () {
                      goHome();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Completed()),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Home',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }

  void nextQuestion() {
    if (number == 9) {
      completed();
    }
    setState(() {
      number = number + 1;
      updateShufleOption();
      _secondsRemaining = 15;
    });
  }

  void completed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Completed()),
    );
  }

  void updateShufleOption() {
    setState(() {
      shuffleOptions = shuffleOption([
        responseData[number]['correct_answer'],
        ...(responseData[number]['incorrect_answers'] as List)
      ]);
    });
  }

  List<String> shuffleOption(List<String> option) {
    List<String> shuffledOptions = List.from(option);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }

  // timer function

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          nextQuestion();
          _secondsRemaining = 15;
          updateShufleOption();
        }
      });
    });
  }

  void goHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InitialQuizPage()),
    );
  }
}
