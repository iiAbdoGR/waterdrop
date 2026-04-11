import 'package:flutter/material.dart';
import 'widgets/custom_bottom_nav.dart';

class ResetAccountScreen extends StatelessWidget {
  const ResetAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F7FC),
      body: Stack(
        children: [
          // Background Decorations
          Positioned(
            top: 80,
            right: -30,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: const Color(0xFF4ECDC4).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 160,
            left: -30,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: const Color(0xFFFFE66D).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 28,
                          color: Color(0xFF0A5C71),
                        ),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const Expanded(
                        child: Text(
                          'Reset Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF0A5C71),
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 28), // Balance for back button
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInputField(
                                      'FIRST NAME',
                                      'Mayar',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildInputField(
                                      'LAST NAME',
                                      'Ahmed',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildInputField(
                                'CHANGE EMAIL',
                                'mayar61134@gmail.com',
                              ),
                              const SizedBox(height: 24),
                              _buildInputField(
                                'CHANGE PASSWORD',
                                '••••••••',
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A5C71),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'RESET',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 100), // padding for bottom nav
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(current: 'settings'),
    );
  }

  Widget _buildInputField(
    String label,
    String hint, {
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0A5C71).withValues(alpha: 0.4),
              letterSpacing: 1.5,
            ),
          ),
        ),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF0A5C71),
              fontWeight: FontWeight.bold,
            ),
            filled: true,
            fillColor: const Color(0xFF0A5C71).withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
          style: const TextStyle(
            color: Color(0xFF0A5C71),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
