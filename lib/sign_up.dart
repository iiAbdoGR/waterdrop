import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Title and Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A5C71),
                          ),
                        ),
                      ),
                      _buildLogo(),
                    ],
                  ),

                  // Welcome Text
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF0A5C71),
                        ),
                      ),
                    ),
                  ),

                  // Form Fields
                  _buildTextField('Full Name :', controller: _nameController),
                  _buildTextField('Email :', controller: _emailController),
                  _buildTextField(
                    'Password :',
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  _buildTextField(
                    'Confirm Password :',
                    isPassword: true,
                    controller: _confirmPasswordController,
                  ),

                  const SizedBox(height: 20),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );

                          await credential.user!.sendEmailVerification();

                          if (!mounted) return;

                          Navigator.pushReplacementNamed(context, '/verify');

                          _nameController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                          _confirmPasswordController.clear();
                        } on FirebaseAuthException catch (e) {
                          if (!mounted) return;

                          String message = "";

                          if (e.code == 'weak-password') {
                            message = "Weak password";
                          } else if (e.code == 'email-already-in-use') {
                            message = "Email already in use";
                          } else {
                            message = "Signup failed";
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Something went wrong"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A5C71),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Footer Link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF0A5C71),
                            fontFamily: 'Georgia',
                          ),
                          children: [
                            TextSpan(text: 'Already have an account ? '),
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, {
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    String hint = "";

    if (label.contains("Name")) {
      hint = "Enter your full name";
    } else if (label.contains("Email")) {
      hint = "Enter your email";
    } else if (label.contains("Confirm")) {
      // 🔥 لازم تيجي قبل Password
      hint = "Confirm your password";
    } else if (label.contains("Password")) {
      hint = "Enter your password";
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Color(0xFF0A5C71),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            // 🔥 بدل TextField
            controller: controller,
            obscureText: isPassword,

            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }

              if (label.contains("Email")) {
                if (!value.contains("@")) {
                  return "Enter a valid email";
                }
              }

              if (label.contains("Password") && !label.contains("Confirm")) {
                if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
              }

              if (label.contains("Confirm")) {
                if (value != _passwordController.text) {
                  return "Passwords do not match";
                }
              }

              return null;
            },

            decoration: InputDecoration(
              hintText: hint,

              filled: true,
              fillColor: Colors.transparent,

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),

              // الشكل الطبيعي
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0A5C71),
                  width: 2,
                ),
              ),

              // لما تدوس
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0A5C71),
                  width: 2,
                ),
              ),

              // 🔥 وقت الخطأ
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),

              errorStyle: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------
  // UPDATED LOGO BUILDER
  // -------------------------
  Widget _buildLogo() {
    return SizedBox(
      width: 195,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // BACK DROPLET (translucent)
          Positioned(
            top: 10,
            right: 0,
            child: Icon(
              Icons.water_drop,
              size: 150,
              color: const Color(0x661CA3C6), // translucent
            ),
          ),

          // OUTLINE / SHADOW DROP
          Positioned(
            top: 40,
            right: 30,
            child: Icon(
              Icons.water_drop,
              size: 150,
              color: Colors.white.withOpacity(0.35),
            ),
          ),

          // MAIN DROP
          Positioned(
            top: 50,
            right: 40,
            child: Icon(
              Icons.water_drop,
              size: 130,
              color: const Color(0xFF1CA3C6),
            ),
          ),

          // TEXT INSIDE DROP
          const Positioned(
            top: 90,
            right: 82,
            child: Text(
              'PURE\nDROP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
