import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for checking user authentication
    // Replace this with your authentication logic
    bool isLoggedIn =
        false; // Placeholder, replace with actual authentication check

    // Delay to simulate app loading
    Future.delayed(Duration(seconds: 2), () {
      // Navigator.of(context).pushReplacementNamed(isLoggedIn ? '/' : '/login');

      if (FirebaseAuth.instance.currentUser?.uid != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 200),
      ),
    );
  }
}
