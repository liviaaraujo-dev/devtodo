import 'package:devtodo/modules/login/components/login_google_button/login_google_button.dart';
import 'package:flutter/material.dart';

import '../../shared/theme/app_images.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(children: [
          Container(
            color: Colors.orange,
            width: size.width,
            height: size.height * 0.3,
          ),
          Positioned(
            child: Image.asset(
              AppImages.person,
              width: 208,
              height: size.height * 0.4,
            ),
            left: 0,
            right: 0,
            top: 55,
          ),
          Positioned(
            top: size.height * 0.52,
            left: 0,
            right: 0,
            child: Column(children: [
              Image.asset(AppImages.logo),
              Text(
                "Organize suas tarefas",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              LoginGoogleButton(
                onTap: () {
                  controller.googleSignIn(context);
                },
              )
            ]),
          )
        ]),
      ),
    );
  }
}
