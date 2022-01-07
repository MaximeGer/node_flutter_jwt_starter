import 'package:flutter/material.dart';
import 'package:mobile/screens/login.dart';
import 'package:mobile/screens/signin.dart';
import 'package:mobile/utils/functions.dart';

class JwtChecker extends StatelessWidget {
  final Widget screen;

  const JwtChecker({Key? key, required this.screen}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true &&
                (screen is! LoginScreen || screen is! SignInScreen)) {
              return screen;
            } else if (screen is LoginScreen || screen is SignInScreen) {
              return screen;
            } else {
              return const LoginScreen();
            }
          } else if (snapshot.hasError) {
            return Text('error ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
