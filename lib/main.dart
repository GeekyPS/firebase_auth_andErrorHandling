import './screens/homescreen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import 'screens/splash_sign_up.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const HomeScreen(),
      routes: {
        LoginScreen.routename: (context) => const LoginScreen(),
        SignupScreen.routename: (context) => const SignupScreen(),
        SplashSignup.routename: (context) => const SplashSignup(),
        HomeScreen.routename: (context) =>  const HomeScreen()
      },
    );
  }
}
