import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'sign_in.dart';
import 'sign_up.dart';
import 'forgot_password.dart';
import 'otp_verification.dart';
import 'create_new_password.dart';
import 'password_success.dart';

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
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/otp_verification': (context) => const OtpVerificationScreen(),
        '/create_new_password': (context) => const CreateNewPasswordScreen(),
        '/password_success': (context) => const PasswordSuccessScreen(),
      },
    );
  }
}
