import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/widgets/JwtChecker.dart';

import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/signin.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate);
  }

  final _router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const JwtChecker(screen: HomeScreen()),
        ),
        // routes: [
        //   GoRoute(
        //     path: ":id",
        //     pageBuilder: (context, state) => MaterialPage(child: const ExerciseDetails()),
        //   )
        // ]
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey, child: const JwtChecker(screen: LoginScreen())),
      ),
      GoRoute(
        path: '/sign-in',
        pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const JwtChecker(screen: SignInScreen())),
      )
    ],
  );
}
