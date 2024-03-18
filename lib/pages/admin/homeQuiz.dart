import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:calculator/pages/guest/completePage.dart';
import 'package:calculator/pages/guest/options.dart';
import 'package:calculator/pages/guest/quizoptions.dart';
import 'package:calculator/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class InitialQuizPage extends StatefulWidget {
  const InitialQuizPage({super.key});

  @override
  State<InitialQuizPage> createState() => _Initialquizpage();
}

class _Initialquizpage extends State<InitialQuizPage> {
  // text controllers
  // final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "signed in as " + user.email!,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
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
                                    '',
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 20),
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20),
                                  )
                                ],
                              ),
                              Center(
                                child: Text(
                                  'Quizes',
                                  style: TextStyle(
                                    color: Colors.amber[800],
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Browse through the quizes below and choose one to attempt',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 1,
            ),
            QuizOptions(option: "QuizA"),
            QuizOptions(option: "QuizB"),
            QuizOptions(option: "QuizC"),
            QuizOptions(option: "QuizD"),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            )
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
}
