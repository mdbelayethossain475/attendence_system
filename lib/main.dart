import 'package:flutter/material.dart';
import 'package:profile_update/HomeScreen.dart';
import 'package:profile_update/LoginScreen.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const KeyboardVisibilityProvider(
          child: AuthCheck(),
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool userAvailable = false;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async{
    sharedPreferences = await SharedPreferences.getInstance();

    try{
      if(sharedPreferences.getString('employee') != null){
        setState(() {
          User.employee = sharedPreferences.getString('employee')!;
          userAvailable = true;
        });
      }
    }catch(e){
      setState(() {
        userAvailable = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return userAvailable ? const HomeScreen() : const LoginScreen();
  }
}

