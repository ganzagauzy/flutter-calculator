import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

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
              // FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.amber[800], // Set background color to amber
            ),
            child: Icon(Icons.logout), // Use icon instead of text
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Stack(
              children: [
                Container(
                  height: 250,
                  width: 410,
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    // borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white.withOpacity(.30),
                    child: CircleAvatar(
                      radius: 51,
                      backgroundColor: Colors.white.withOpacity(.4),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text: '100',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber[800]),
                                      children: [
                                    TextSpan(
                                        text: 'pt',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.amber[900]))
                                  ]))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                ),
                Positioned(
                  bottom: 0,
                  left: 22,
                  child: Container(
                    height: 190,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: Colors.amber,
                            offset: Offset(0, 1),
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.amber),
                                        ),
                                        Text(
                                          '100%',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: Colors.amber,
                                          ),
                                        )
                                      ]),
                                    ),
                                    Text('Completion')
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.amber),
                                        ),
                                        Text(
                                          '10',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: Colors.amber,
                                          ),
                                        )
                                      ]),
                                    ),
                                    Text('Total Questions')
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(children: [
                                        Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                        ),
                                        Text(
                                          '07',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                            color: Colors.green,
                                          ),
                                        )
                                      ]),
                                    ),
                                    Text('Correct')
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 55),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            '03',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              color: Colors.red,
                                            ),
                                          )
                                        ]),
                                      ),
                                      Text('Wrong')
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
