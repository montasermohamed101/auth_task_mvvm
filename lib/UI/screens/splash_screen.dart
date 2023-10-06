import 'package:flutter/material.dart';

import '../../data/repo/auth_repo/auth_repo_impl.dart';
import '../../domain/repo/auth_repo/auth_repo.dart';
import 'auth/login/login.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AuthRepo repo = AuthRepoImpl();
      bool isLoggedIn = await repo.isAuthorized();
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, Login.routeName);
      }
    });

    return Scaffold(
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            fontSize: 90,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
