import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCred = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final user = userCred.user!;
    final firstName = (user.displayName ?? "").split(" ").first;

    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'name': firstName,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await userDoc.collection('readings').add({
        'ph': 7.0,
        'temp': 25,
        'tds': 100,
        'turbidity': 1.0,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } else {
      await userDoc.set({
        'name': firstName,
        'email': user.email,
      }, SetOptions(merge: true));
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginType', 'google');
    await prefs.setBool('rememberMe', true);

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/connect_device',
      (route) => false,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                          'Sign In',
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
                  const SizedBox(height: 60),

                  // Form Fields
                  _buildTextField('Email :', controller: _emailController),
                  _buildTextField(
                    'Password :',
                    isPassword: true,
                    controller: _passwordController,
                  ),

                  // Forgot Password
                  GestureDetector(
                    onTap: () {
                      _emailController.clear();
                      _passwordController.clear();
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        color: Color(0xFF0A5C71),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Remember Me Checkbox
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                          side: const BorderSide(
                            color: Color(0xFF0A5C71),
                            width: 1.5,
                          ),
                          activeColor: const Color(0xFF0A5C71),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Remember Me',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF0A5C71),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }

                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('loginType', 'email');
                          await prefs.setBool('rememberMe', _rememberMe);
                          if (!mounted) return;

                          Navigator.pushReplacementNamed(
                            context,
                            '/connect_device',
                          );

                          _passwordController.clear();
                          _emailController.clear();
                        } on FirebaseAuthException catch (e) {
                          if (!mounted) return;

                          String message = "";

                          if (e.code == 'user-not-found') {
                            message = "No user found with this email";
                          } else if (e.code == 'wrong-password') {
                            message = "Wrong password";
                          } else {
                            message = "Login failed";
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
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
                        'Sign In',
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // OR DIVIDER
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(color: Color(0xFF0A5C71), thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Color(0xFF0A5C71),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Color(0xFF0A5C71), thickness: 1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // GOOGLE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        signInWithGoogle();
                      },
                      icon: Image.asset('assets/google.png', height: 24),
                      label: const Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A5C71),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Color(0xFF0A5C71)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Footer Link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signup');
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
                            TextSpan(text: 'Not a member ? '),
                            TextSpan(
                              text: 'Sign Up',
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
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

              if (label.contains("Password")) {
                if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: isPassword ? "Enter your password" : "Enter your email",

              filled: true,
              fillColor: Colors.transparent,

              // الشكل الأساسي
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0A5C71),
                  width: 2,
                ),
              ),

              // لما تدوس عليه
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0A5C71),
                  width: 2, // 🔥 زودها
                ),
              ),

              // 🔥 مهم جدًا (وقت الخطأ)
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2, // 🔥 نفس السمك
                ),
              ),

              // 🔥 لما يكون focused + error
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),

              // شكل الرسالة
              errorStyle: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 200,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 10,
            right: 0,
            child: Icon(
              Icons.water_drop,
              size: 150,
              color: const Color(0x661CA3C6),
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: Icon(Icons.water_drop, size: 150, color: Colors.white24),
          ),
          Positioned(
            top: 50,
            right: 40,
            child: Icon(
              Icons.water_drop,
              size: 130,
              color: const Color(0xFF1CA3C6),
            ),
          ),
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
