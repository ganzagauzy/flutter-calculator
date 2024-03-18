import 'package:calculator/button_values.dart';
import 'package:calculator/pages/admin/quizoptions.dart';
import 'package:calculator/pages/admin/createQuiz.dart';
import 'package:flutter/material.dart';

class AdminQuizPage extends StatefulWidget {
  const AdminQuizPage({super.key});

  @override
  State<AdminQuizPage> createState() => _Adminquizpage();
}

class _Adminquizpage extends State<AdminQuizPage> {
  String number1 = ""; // . 0-9
  String operand = ""; // + - * /
  String number2 = ""; // . 0-9

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Available quizes",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    selectionColor: Colors.amber,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
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
                      goCreateQuiz();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Completed()),
                      // );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '+Quiz',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QuizOptions(option: 'Quiz A'),
                        QuizOptions(option: 'Quiz B'),
                        QuizOptions(option: 'Quiz C'),
                        QuizOptions(option: 'Quiz D'),
                      ],
                    )),
              ],
            )),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
    );
  }

  void goCreateQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateQuizPage()),
    );
  }
}
