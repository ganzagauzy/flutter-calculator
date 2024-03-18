import 'package:flutter/material.dart';
import 'package:calculator/pages/guest/quiz.dart';

class QuizOptions extends StatefulWidget {
  String option;
  QuizOptions({super.key, required this.option});

  @override
  State<QuizOptions> createState() => _QuizoptionsState();
}

class _QuizoptionsState extends State<QuizOptions> {
  bool _isSelected = false;
  int _currestOption = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 3, color: Colors.amber)),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Text(
                    widget.option,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Radio(
                      value: widget.option,
                      groupValue: _currestOption,
                      onChanged: (val) {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                        checkSelected(val);
                      })
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  checkSelected(val) {
    _currestOption = 1;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GuestQuizPage()),
    );
  }
}
