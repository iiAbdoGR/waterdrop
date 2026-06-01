import 'package:flutter/material.dart';
import 'widgets/custom_bottom_nav.dart';
import 'home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'contact_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String email,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(email),

      onTap: () async {
        final uri = Uri(
          scheme: 'mailto',
          path: email,
          query: 'subject=Water App Support',
        );

        await launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 28,
                          color: Color(0xFF0A5C71),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0A5C71),
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(width: 40), // Placeholder for alignment
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildSettingsButton(
                          context,
                          icon: Icons.person,
                          iconColor: Colors.cyan,
                          iconBgColor: Colors.cyan.shade100,
                          title: 'Personal Information',
                          onTap: () =>
                              Navigator.pushNamed(context, '/personal_info'),
                        ),
                        const SizedBox(height: 16),
                        _buildSettingsButton(
                          context,
                          icon: Icons.language,
                          iconColor: Colors.orange,
                          iconBgColor: Colors.orange.shade100,
                          title: 'Region & Languages',
                          onTap: () =>
                              Navigator.pushNamed(context, '/region_language'),
                        ),
                        const SizedBox(height: 16),
                        _buildSettingsButton(
                          context,
                          icon: Icons.star,
                          iconColor: Colors.yellow.shade700,
                          iconBgColor: Colors.yellow.shade100,
                          title: 'Rate The App',
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        _buildSettingsButton(
                          context,
                          icon: Icons.mail,
                          iconColor: Colors.purple,
                          iconBgColor: Colors.purple.shade100,
                          title: 'Contact US',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Contact Us",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 15),

                                      _buildContactItem(
                                        icon: Icons.email,
                                        title: "Abdalrahman",
                                        email: "iiabdogr@gmail.com",
                                      ),

                                      _buildContactItem(
                                        icon: Icons.email,
                                        title: "Menna",
                                        email: "menna.soliman44@gmail.com",
                                      ),

                                      _buildContactItem(
                                        icon: Icons.email,
                                        title: "Mayar",
                                        email: "mayar61134@gmail.com ",
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              // تسجيل خروج من Firebase
                              await FirebaseAuth.instance.signOut();

                              // تسجيل خروج من Google
                              GoogleSignIn googleSignIn = GoogleSignIn();
                              googleSignIn.disconnect();

                              // مسح النافيجيشن
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/signin',
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(
                                alpha: 0.8,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: BorderSide(
                                  color: Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                            child: const Text(
                              'LOG OUT',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.red,
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

  Widget _buildSettingsButton(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0A5C71),
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF0A5C71).withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
