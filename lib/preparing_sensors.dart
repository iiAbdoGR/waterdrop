import 'package:flutter/material.dart';
import 'dart:async';

class PreparingSensorsScreen extends StatefulWidget {
  const PreparingSensorsScreen({super.key});

  @override
  State<PreparingSensorsScreen> createState() => _PreparingSensorsScreenState();
}

class _PreparingSensorsScreenState extends State<PreparingSensorsScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/connect_device');
    });
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
                    const Expanded(
                      child: Text(
                        'Preparing\nSensors',
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
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1CA3C6).withValues(alpha: 0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.water_drop,
                  size: 160,
                  color: Color(0xFF1CA3C6),
                ),
              ),
              const SizedBox(height: 60),
              const Text(
                'Place sensors in water to begin',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF0A5C71),
                  fontFamily: 'Georgia',
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Status : Waiting...',
                style: TextStyle(fontSize: 16, color: Color(0xFF0A5C71)),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
