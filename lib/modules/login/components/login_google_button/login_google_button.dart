import 'package:devtodo/shared/theme/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginGoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginGoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: Row(
        children: [
          Image.asset(AppImages.google),
          Text(
            "Entrar com o google",
            style: Theme.of(context).textTheme.button,
          )
        ],
      )),
    );
  }
}
