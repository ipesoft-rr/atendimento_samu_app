import 'package:atendimento_samu_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:atendimento_samu_app/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isActive = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo ONBOARDING",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: _isActive ? HomeScreen() : OnboardingScreen(),
    );
  }

  _initAppCheckIsActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final active = prefs.getBool('ativo') ?? false;

    setState(() {
      _isActive = active;
    });
  }
}
