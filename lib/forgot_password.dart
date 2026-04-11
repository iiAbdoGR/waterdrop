import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waterdrop/email_sent.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE6F7FC), Color(0xFF9CE3F5)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Form(
              // 🔥 مهم
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF0A5C71),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Need help ?',
                        style: TextStyle(
                          color: Color(0xFF0A5C71),
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Reset Your Password',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A5C71),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Enter your email and we will send you a link to reset your password.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF0A5C71),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    'Email',
                    style: TextStyle(fontSize: 16, color: Color(0xFF0A5C71)),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    onChanged: (value) {
                      if (_emailError != null) {
                        setState(() {
                          _emailError = null;
                        });
                      }
                    },

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return "Enter a valid email";
                      }

                      return _emailError;
                    },

                    decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      prefixIcon: const Icon(Icons.email),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF0A5C71)),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF0A5C71),
                          width: 2,
                        ),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _emailError = null;
                        });

                        if (!_formKey.currentState!.validate()) return;

                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _emailController.text.trim(),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EmailSentScreen(
                                email: _emailController.text.trim(),
                              ),
                            ),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            _emailError = "No account found with this email";
                          } else if (e.code == 'invalid-email') {
                            _emailError = "Enter a valid email";
                          } else {
                            _emailError = "Something went wrong";
                          }

                          setState(() {});
                          _formKey.currentState!.validate();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A5C71),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
