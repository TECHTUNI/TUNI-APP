import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;

    Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });

    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 200),
      ),
    );
  }
}
