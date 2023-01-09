import 'package:devtodo/shared/theme/app_images.dart';
import 'package:flutter/material.dart';

class LoginGoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const LoginGoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar();
    var size = MediaQuery.of(context).size;
    var screenHeight = (size.height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: size.width * 0.8,
          height: screenHeight * 0.065,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xFFB0B0B0)),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Image.asset(AppImages.google),
              SizedBox(
                width: 15,
              ),
              Text(
                "Entrar com o google",
                style: Theme.of(context).textTheme.button,
              )
            ],
          )),
    );
  }
}
