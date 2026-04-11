import 'package:flutter/material.dart';
import 'widgets/custom_bottom_nav.dart';

class AnalyzingWaterScreen extends StatefulWidget {
  const AnalyzingWaterScreen({super.key});

  @override
  State<AnalyzingWaterScreen> createState() => _AnalyzingWaterScreenState();
}

class _AnalyzingWaterScreenState extends State<AnalyzingWaterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/home');
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
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF0A5C71),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'Analyzing\nWater...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A5C71),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF0A5C71),
                      ),
                      backgroundColor: const Color(
                        0xFF0A5C71,
                      ).withValues(alpha: 0.1),
                      strokeWidth: 8,
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1CA3C6).withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.water_drop,
                      size: 100,
                      color: Color(0xFF1CA3C6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              const Text(
                'Collecting stable measurements',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0A5C71),
                  fontFamily: 'Georgia',
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(current: ''),
    );
  }
}
