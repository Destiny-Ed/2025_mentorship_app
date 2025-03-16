import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/views/firebase_auth/firebase_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash screen"),
      ),
    );
  }

  void navigate() {
    // Navigate to your main app
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirebaseLogin()), (_) => false);
        } else {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (_) => false);
        }
      }
    });
  }
}
