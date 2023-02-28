import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // your logic to check whether user is signed in or not
    // If user is logged in navigate to HomePage widget
    // Else navigate to SignInPage
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 50,
      child: Center(child: CircularProgressIndicator()));
  }
}