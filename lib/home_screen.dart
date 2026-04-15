import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waterdrop/referesh.dart';
import 'package:waterdrop/services/firestore_service.dart';
import 'widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String _selectedDeviceId = 'device_a';
  String _selectedDeviceName = 'Device A';
  bool _isDeviceDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _seedData();
  }

  Future<void> _seedData() async {
    try {
      await _firestoreService.seedInitialData();
    } catch (e) {
      debugPrint('Seed data error (non-blocking): $e');
    }
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
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isDeviceDropdownOpen = !_isDeviceDropdownOpen;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(
                                  0xFF0A5C71,
                                ).withValues(alpha: .1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _selectedDeviceName,
                                  style: const TextStyle(
                                    color: Color(0xFF0A5C71),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  _isDeviceDropdownOpen
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: const Color(0xFF0A5C71),
                                  size: 20,
                                ),
                              ],
                            ),
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
                              color: Color(0xFF0A5C71),
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RefreshScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Greeting — from Firebase Auth
                    Text(
                      'Hello, ${_firestoreService.currentUserName}!',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0A5C71),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Real-time water status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0A5C71).withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Main Quality Card — from Firestore
                    StreamBuilder<DocumentSnapshot>(
                      stream: _firestoreService.getDeviceOverviewStream(_selectedDeviceId),
                      builder: (context, snapshot) {
                        int score = 62;
                        String condition = 'Excellent Condition';
                        bool safeForUse = true;

                        if (snapshot.hasData && snapshot.data!.exists) {
                          final data = snapshot.data!.data() as Map<String, dynamic>;
                          score = data['overallScore'] ?? 62;
                          condition = data['condition'] ?? 'Excellent Condition';
                          safeForUse = data['safeForUse'] ?? true;
                        }

                        return Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF0A5C71),
                                Color(0xFF1CA3C6),
                                Color(0xFF0A5C71),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF0A5C71,
                                ).withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.1,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF4ECDC4),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            const Text(
                                              'LIVE MONITORING',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        condition,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.2),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.show_chart,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '$score',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 56,
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    '/100',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.4),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Overall Water Quality Score',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      safeForUse ? Icons.check_circle : Icons.warning,
                                      color: safeForUse
                                          ? const Color(0xFF4ECDC4)
                                          : const Color(0xFFFF6B6B),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      safeForUse
                                          ? 'Status: Safe for use'
                                          : 'Status: Not safe for use',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Sensor Grid — from Firestore
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestoreService.getSensorsStream(_selectedDeviceId),
                      builder: (context, snapshot) {
                        // If still loading or no data, show default cards
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return _buildDefaultSensorGrid();
                        }

                        final sensors = snapshot.data!.docs;
                        // Map sensor IDs to their display properties
                        final sensorConfigs = {
                          'ph': {'icon': Icons.water_drop, 'color': const Color(0xFF4ECDC4)},
                          'temp': {'icon': Icons.thermostat, 'color': const Color(0xFFFF9F1C)},
                          'tds': {'icon': Icons.waves, 'color': const Color(0xFF1CA3C6)},
                          'turbidity': {'icon': Icons.bolt, 'color': const Color(0xFF9D4EDD)},
                        };

                        // Build sensor cards in a 2-column grid
                        List<Widget> rows = [];
                        for (int i = 0; i < sensors.length; i += 2) {
                          final first = sensors[i];
                          final firstData = first.data() as Map<String, dynamic>;
                          final firstConfig = sensorConfigs[first.id] ?? sensorConfigs['ph']!;

                          // Build display value with unit
                          String firstDisplayValue = firstData['value'] ?? '0';
                          String firstUnit = firstData['unit'] ?? '';
                          if (firstUnit.isNotEmpty) {
                            firstDisplayValue = '$firstDisplayValue $firstUnit';
                          }

                          Widget firstCard = Expanded(
                            child: _buildSensorCard(
                              firstData['name'] ?? 'Sensor',
                              firstDisplayValue,
                              firstData['status'] ?? 'Unknown',
                              firstConfig['icon'] as IconData,
                              firstConfig['color'] as Color,
                            ),
                          );

                          Widget secondCard;
                          if (i + 1 < sensors.length) {
                            final second = sensors[i + 1];
                            final secondData = second.data() as Map<String, dynamic>;
                            final secondConfig = sensorConfigs[second.id] ?? sensorConfigs['ph']!;

                            String secondDisplayValue = secondData['value'] ?? '0';
                            String secondUnit = secondData['unit'] ?? '';
                            if (secondUnit.isNotEmpty) {
                              secondDisplayValue = '$secondDisplayValue $secondUnit';
                            }

                            secondCard = Expanded(
                              child: _buildSensorCard(
                                secondData['name'] ?? 'Sensor',
                                secondDisplayValue,
                                secondData['status'] ?? 'Unknown',
                                secondConfig['icon'] as IconData,
                                secondConfig['color'] as Color,
                              ),
                            );
                          } else {
                            secondCard = const Expanded(child: SizedBox());
                          }

                          rows.add(Row(
                            children: [
                              firstCard,
                              const SizedBox(width: 16),
                              secondCard,
                            ],
                          ));
                          if (i + 2 < sensors.length) {
                            rows.add(const SizedBox(height: 16));
                          }
                        }

                        return Column(children: rows);
                      },
                    ),
                    const SizedBox(height: 100), // Space for bottom nav
                  ],
                ),
              ),

              // Dropdown Overlay — from Firestore
              if (_isDeviceDropdownOpen)
                Positioned(
                  top: 70,
                  left: 24,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestoreService.getDevicesStream(),
                    builder: (context, snapshot) {
                      List<Map<String, String>> devices = [];

                      if (snapshot.hasData) {
                        devices = snapshot.data!.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return {
                            'id': doc.id,
                            'name': (data['name'] ?? doc.id) as String,
                          };
                        }).toList();
                      }

                      if (devices.isEmpty) {
                        devices = [
                          {'id': 'device_a', 'name': 'Device A'},
                        ];
                      }

                      return Material(
                        color: Colors.transparent,
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF0A5C71,
                                ).withValues(alpha: 0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: devices.map((device) {
                              final isSelected = _selectedDeviceId == device['id'];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedDeviceId = device['id']!;
                                    _selectedDeviceName = device['name']!;
                                    _isDeviceDropdownOpen = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(
                                            0xFF1CA3C6,
                                          ).withValues(alpha: 0.05)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        device['name']!,
                                        style: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFF1CA3C6)
                                              : const Color(0xFF0A5C71),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 14,
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check,
                                          color: Color(0xFF1CA3C6),
                                          size: 16,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(current: 'home'),
    );
  }

  Widget _buildSensorCard(
    String title,
    String value,
    String status,
    IconData icon,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0A5C71).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF0A5C71).withValues(alpha: 0.6),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF0A5C71),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: TextStyle(
              color: iconColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// Fallback sensor grid with default values (shown while Firestore loads)
  Widget _buildDefaultSensorGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSensorCard(
                'pH Level',
                '7.2',
                'Optimal',
                Icons.water_drop,
                const Color(0xFF4ECDC4),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSensorCard(
                'Temperature',
                '24°C',
                'Normal',
                Icons.thermostat,
                const Color(0xFFFF9F1C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSensorCard(
                'TDS',
                '120 ppm',
                'Good',
                Icons.waves,
                const Color(0xFF1CA3C6),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSensorCard(
                'Turbidity',
                '1.5 NTU',
                'Clear',
                Icons.bolt,
                const Color(0xFF9D4EDD),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
