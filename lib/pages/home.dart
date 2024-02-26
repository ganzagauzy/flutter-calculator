import 'dart:typed_data';

import 'package:calculator/button_values.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io'
    show
        File,
        Platform; // Import File and Platform from dart:io for non-web platforms

// Import dart:html libraries only for web platform
import 'dart:html' as html show File, InputElement;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String number1 = ""; // . 0-9
  String operand = ""; // + - * /
  String number2 = ""; // . 0-9
  final user = FirebaseAuth.instance.currentUser!;
  File? _selectedIage;
  Uint8List? _imageData;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Home",
                    selectionColor: Colors.amber,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(children: [
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                      selectionColor: Colors.amber,
                    ),
                    SizedBox(height: 30),
                    Text("signed i as " + user.email!),
                    // SizedBox(height: 30),
                    // _selectedIage != null
                    //     ? Image.asset(_selectedIage!.path)
                    //     : const Text("Plz select image"),
                    SizedBox(height: 25),
                    MaterialButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      color: Colors.red,
                      child: Text("Logout"),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 25),
                    MaterialButton(
                        color: Colors.blue,
                        child: const Text(
                          "Pick image from galery",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          _pickImageFromGalery();
                        }),
                    SizedBox(height: 25),
                    MaterialButton(
                        color: Colors.amber,
                        child: const Text(
                          "Pick image from camera",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          _pickImageFromCamera();
                        }),
                    SizedBox(height: 25),
                  ]),
                ),
                if (_imageData != null)
                  Container(
                    width: 300,
                    height: 300,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_imageData!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Text('No image selected'),
                SizedBox(height: 25),
              ],
            ),
          )),
    );
  }

  Future _pickImageFromGalery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      final bytesData = await returnedImage.readAsBytes();
      setState(() {
        _imageData = bytesData;
      });
    }

    // setState(() {
    //   _selectedIage = File(returnedImage!.path);
    // });
  }

  Future _pickImageFromCamera() async {
    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
  }

  // Widget buildButton(value) {
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //   );
  // }
}
