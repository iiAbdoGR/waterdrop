import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'sign_up.dart';

void main() {
  runApp(const PureDropApp());
}

class PureDropApp extends StatelessWidget {
  const PureDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pure Drop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0A5C71),
        fontFamily: 'Georgia', // Using a serif font to match the design
        scaffoldBackgroundColor: const Color(0xFFBCE6F4),
      ),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}
