import 'dart:async';

import 'package:devtodo/modules/login/login_page.dart';
import 'package:flutter/material.dart';
import '../../shared/theme/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _isLogado() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 6), () => _isLogado());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppImages.logoSplash)),
    );
  }
}
