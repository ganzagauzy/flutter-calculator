import 'package:calculator/calculator_screen.dart';
import 'package:calculator/pages/about.dart';
import 'package:calculator/pages/home.dart';
import 'package:calculator/pages/login.dart';
import 'package:calculator/dependency_injection.dart';
import 'package:calculator/theme/theme_provider.dart';
import 'package:calculator/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:calculator/pages/register.dart';
import 'package:flutter/material.dart';

import 'mainPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // DependecyInjection.init();
  runApp(const MyApp());
  // DependecyInjection.init();
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => ThemeProvider(),
  //     child: MyApp(),
  //   ),
  // );
}

bool _isDarkMode = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, __) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          // themeMode: mode,
          // theme: Provider.of<ThemeProvider>(context).themeData,
          themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          // ),
          home: MainPage(),
          // home: const MyHomePage(title: 'Flutter App'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  // Track the current theme mode
  // Function to toggle between light and dark themes
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Toggle the theme mode

      // themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
      if (_isDarkMode) {
        ThemeData.dark();
      } else {
        ThemeData.light();
      }
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 1: Calculator',
    //   style: optionStyle,
    // ),

    // HomePage(),

    HomeScreen(),
    CalculatorScreen(),
    About(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
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
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              _toggleTheme();
              ThemeData.light();
            },
            padding: EdgeInsets.all(16.16),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       _toggleTheme();
          //       ThemeData.dark();
          //     },
          //     child: Text("data"))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 0; // Set the selected index to Home
                });
              },
            ),
            ListTile(
              title: const Text("Calculator"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 1; // Set the selected index to Home
                });
              },
            ),
            ListTile(
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _selectedIndex = 2; // Set the selected index to Home
                });
              },
            ),
            ListTile(
              title: const Text("Login"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            )
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(
          _selectedIndex,
        ),
        // child: ElevatedButton(onPressed: () {}, child: Text("Toogle theme")),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Login',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDarkMode ? Colors.white : Colors.black,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        // backgroundColor: Colors.grey[50],
      ),
    );
  }
}
