import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'your email';

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
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF0A5C71),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 30),
                const Text(
                  'OTP Code Verification',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A5C71),
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF0A5C71),
                      height: 1.5,
                      fontFamily: 'Georgia',
                    ),
                    children: [
                      const TextSpan(
                        text: 'we have sent an OTP code to your email ',
                      ),
                      TextSpan(
                        text: email,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: ' Enter the OTP code below to verify',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return SizedBox(
                      width: 55,
                      height: 55,
                      child: TextField(
                        controller: _controllers[index],
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF0A5C71),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    "Didn't receive the code?",
                    style: TextStyle(fontSize: 14, color: Color(0xFF0A5C71)),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF0A5C71),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      for (var controller in _controllers) {
                        controller.clear();
                      }
                      Navigator.pushNamed(context, '/create_new_password');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A5C71),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Submit',
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
    );
  }
}
