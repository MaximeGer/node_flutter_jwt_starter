import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/utils/functions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                  controller: email,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                  controller: password,
                ),
              ),
              Text(errorText),
              TextButton(
                  onPressed: () async {
                    // errorText = "lol";
                    errorText = "";
                    setState(() {});
                    errorText = await signin(email.text, password.text);
                    setState(() {});
                    if (await isLogged()) {
                      context.go("/");
                    }
                  },
                  child: const Text("Sign In")),
              // const Spacer(),
              TextButton(
                child: const Text("Login"),
                onPressed: () => context.go("/login"),
              ),
            ],
          ),
        ));
  }
}
