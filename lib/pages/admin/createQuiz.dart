import 'package:calculator/pages/login.dart';
import 'package:calculator/pages/admin/homeQuiz.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  // text controllers
  final _nameController = TextEditingController();
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
      postToFirestore();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginPage()),
      // );
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

  void postToFirestore() {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = FirebaseAuth.instance.currentUser!;
      CollectionReference ref = FirebaseFirestore.instance.collection('users');
      ref.doc(user.uid).set({
        'email': _emailController.text.trim(),
        'name': _nameController.text.trim(),
        'role': "guest"
      });
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      // Navigate to the next page using Navigator
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InitialQuizPage()),
      );
    } catch (e) {
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                // hello again
                Text(
                  "Create Quiz",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                ),

                SizedBox(
                  height: 50,
                ),

                //name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Quiz Title",
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Question 1',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                //email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Option A",
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Option B",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Option C",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Option D",
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                SizedBox(
                  height: 20,
                ),

                //sign up button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signup,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.amber[800],
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text(
                        "Create Quiz",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                // not a member register
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        "go to quizes",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: Text(
                          " Quizes",
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitialQuizPage()),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
