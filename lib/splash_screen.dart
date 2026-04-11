import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    // 🔥 بدل Timer
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;

        Navigator.pushReplacementNamed(context, '/signin');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
        child: Center(
          child: SizedBox(
            width: 200,
            height: 250,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outline drop
                    const Icon(
                      Icons.water_drop_outlined,
                      size: 200,
                      color: Color(0xFF1CA3C6),
                    ),

                    // BLUE text (base)
                    const Text(
                      "Pure\nDrop",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1CA3C6),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontFamily: 'Georgia',
                      ),
                    ),

                    // Filled part + WHITE text
                    ClipRect(
                      clipper: _WaterFillClipper(_animation.value),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.water_drop,
                            size: 200,
                            color: Color(0xFF1CA3C6),
                          ),

                          // White text when filled
                          const Text(
                            "Pure\nDrop",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WaterFillClipper extends CustomClipper<Rect> {
  final double fillPercent;
  _WaterFillClipper(this.fillPercent);

  @override
  Rect getClip(Size size) {
    final top = size.height - (size.height * fillPercent);
    return Rect.fromLTRB(0, top, size.width, size.height);
  }

  @override
  bool shouldReclip(_WaterFillClipper oldClipper) =>
      oldClipper.fillPercent != fillPercent;
}
