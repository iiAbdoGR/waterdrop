import 'package:flutter/material.dart';
import 'package:waterdrop/referesh.dart';
import 'widgets/custom_bottom_nav.dart';

class SensorsScreen extends StatelessWidget {
  const SensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sensors = [
      {
        'id': 'ph',
        'name': 'pH Level',
        'value': '7.2',
        'unit': '',
        'status': 'Optimal',
        'color': const Color(0xFF4ECDC4),
        'icon': Icons.water_drop,
        'desc': 'Measures the acidity or alkalinity of the water.',
      },
      {
        'id': 'temp',
        'name': 'Temperature',
        'value': '24.5',
        'unit': '°C',
        'status': 'Normal',
        'color': const Color(0xFFFF9F1C),
        'icon': Icons.thermostat,
        'desc': 'Current water temperature.',
      },
      {
        'id': 'tds',
        'name': 'TDS',
        'value': '120',
        'unit': 'ppm',
        'status': 'Good',
        'color': const Color(0xFF1CA3C6),
        'icon': Icons.grain,
        'desc': 'Total Dissolved Solids in the water.',
      },
      {
        'id': 'turbidity',
        'name': 'Turbidity',
        'value': '1.5',
        'unit': 'NTU',
        'status': 'Clear',
        'color': const Color(0xFF9D4EDD),
        'icon': Icons.waves,
        'desc': 'Clarity of the water.',
      },
    ];

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
                      const Text(
                        'Sensors Info',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0A5C71),
                          letterSpacing: -0.5,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            size: 20,
                            color: Color(0xFF0A5C71),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RefreshScreen(),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: sensors.length,
                    itemBuilder: (context, index) {
                      final sensor = sensors[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/sensor_detail',
                              arguments: sensor,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(24),
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
                            child: Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: (sensor['color'] as Color)
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    sensor['icon'] as IconData,
                                    color: sensor['color'] as Color,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sensor['name'] as String,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF0A5C71),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        sensor['desc'] as String,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(
                                            0xFF0A5C71,
                                          ).withValues(alpha: 0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          sensor['value'] as String,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFF0A5C71),
                                          ),
                                        ),
                                        if ((sensor['unit'] as String)
                                            .isNotEmpty) ...[
                                          const SizedBox(width: 2),
                                          Text(
                                            sensor['unit'] as String,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(
                                                0xFF0A5C71,
                                              ).withValues(alpha: 0.5),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (sensor['color'] as Color)
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        sensor['status'] as String,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: sensor['color'] as Color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 80), // padding for bottom nav
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(current: 'sensors'),
    );
  }
}
