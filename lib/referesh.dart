import 'dart:async';
import 'package:flutter/material.dart';

class RefreshScreen extends StatefulWidget {
  const RefreshScreen({super.key});

  @override
  State<RefreshScreen> createState() => _RefreshScreenState();
}

class _RefreshScreenState extends State<RefreshScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Simulate a refresh process then go back
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pop(context);
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
            colors: [Color(0xFFF0F9FA), Color(0xFFBCE6F4)],
          ),
        ),
        child: Stack(
          children: [
            // Background Decorations
            Positioned(
              top: -50,
              right: -50,
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1CA3C6),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4ECDC4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Transform.rotate(
                          angle: _rotationAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF0A5C71).withOpacity(0.1),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.refresh_rounded,
                              size: 60,
                              color: Color(0xFF1CA3C6),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'REFRESHING DATA',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0A5C71),
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Updating sensor information...',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF0A5C71).withOpacity(0.6),
                      fontFamily: 'Georgia',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
