import 'package:flutter/material.dart';

import 'auth/login/login.dart';

class Splash extends StatefulWidget {
  static String routeName="splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, Login.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffddead9),
      body:
          Center(child: Image.asset("assets/logo.png")),
    );
  }
}
