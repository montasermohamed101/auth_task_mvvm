import 'package:flutter/material.dart';

import 'UI/screens/auth/login/login.dart';
import 'UI/screens/home_screen.dart';
import 'UI/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        Login.routeName :(_) =>  Login(),
        HomeScreen.routeName :(_) =>  HomeScreen(),
        SplashScreen.routeName :(_) =>  SplashScreen(),
      },
      initialRoute: SplashScreen.routeName,

    );
  }
}

