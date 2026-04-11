// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isLoading = false;

  Future<void> checkEmailVerified() async {
    setState(() => isLoading = true);

    await FirebaseAuth.instance.currentUser!.reload();
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user!.emailVerified) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email not verified yet ❌"),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => isLoading = false);
  }

  Future<void> resendEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Verification email sent again 📩"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser?.email ?? "";

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE6F7FC), Color(0xFF9CE3F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),

                const Text(
                  "Verify Your Email",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A5C71),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "We sent a verification link to:",
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 10),

                Text(
                  email,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A5C71),
                  ),
                ),

                const SizedBox(height: 40),

                const Icon(
                  Icons.email_outlined,
                  size: 100,
                  color: Color(0xFF0A5C71),
                ),

                const SizedBox(height: 40),

                const Text(
                  "Please check your email and click the verification link",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : checkEmailVerified,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A5C71),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "I Verified",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                TextButton(
                  onPressed: resendEmail,
                  child: const Text(
                    "Resend Email",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color(0xFF0A5C71),
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
