import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailSentScreen extends StatelessWidget {
  final String email;

  const EmailSentScreen({super.key, required this.email});

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 🔥 مهم
              children: [
                /// 🔼 الجزء العلوي
                Column(
                  children: [
                    const SizedBox(height: 30),

                    const Icon(
                      Icons.mark_email_read_rounded,
                      size: 120,
                      color: Color(0xFF0A5C71),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Check Your Email ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A5C71),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// 🔥 رسالة Secure
                    Text(
                      "A password reset link has been sent to:\n$email",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0A5C71),
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// 🔁 Resend Section
                    Column(
                      children: [
                        const Text(
                          "Didn't receive the email?",
                          style: TextStyle(color: Color(0xFF0A5C71)),
                        ),

                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: email,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Email sent again 📩"),
                              ),
                            );
                          },
                          child: const Text(
                            "Resend Email",
                            style: TextStyle(
                              color: Color(0xFF0A5C71),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// 🔽 الزرار تحت
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/signin',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A5C71),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Return to Sign In",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
