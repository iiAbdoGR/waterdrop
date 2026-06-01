import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_bottom_nav.dart';
import 'utils/esp_service.dart';
import 'package:waterdrop/utils/water_logic.dart';
import 'utils/water_quality.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool isConnected = false;
  double temp = 0;
  double ph = 0;
  double turb = 0;
  int tds = 0;
  double displayScore = 0;
  String getTitle() {
    if (displayScore >= 90) return "Excellent Condition";
    if (displayScore >= 75) return "Good Condition";
    if (displayScore >= 50) return "Moderate";
    return "Poor Quality";
  }

  Color getMainColor() {
    if (displayScore >= 90) return Colors.teal;
    if (displayScore >= 75) return Colors.green;
    if (displayScore >= 50) return Colors.orange;
    return Colors.red;
  }

  String getStatusText() {
    if (displayScore >= 75) return "Safe for use";
    if (displayScore >= 50) return "Use with caution";
    return "Not safe";
  }

  String displayStatus = '';

  bool isSafe = false;

  final ESPService espService = ESPService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    espService.onConnectionChanged = (connected) {
      if (!mounted) return;
      setState(() => isConnected = connected);
    };

    espService.onData = (data) {
      if (!mounted) return;

      setState(() {
        temp = (data['temp'] ?? -1).toDouble();
        ph = (data['ph'] ?? -1).toDouble();
        tds = (data['tds'] ?? -1).toInt();
        turb = (data['turb'] ?? -1).toDouble();

        var result = WaterQualityModel.predict(
          ph: ph,
          tds: tds.toDouble(),
          temperature: temp,
          turbidity: turb,
        );
        displayScore = (result['confidence'] * 100).clamp(0, 100);
        displayStatus = result['status'];
        isSafe = result['potable'];
      });
    };

    espService.connect();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      espService.connect();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    espService.disconnect();

    super.dispose();
  }

  Stream<Map<String, dynamic>?> getLatestReading() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('readings')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
          if (snapshot.docs.isEmpty) return null;
          return snapshot.docs.first.data();
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
                        // 🔴 Status Box
                        GestureDetector(
                          onTap: () async {
                            Navigator.pushNamed(
                              context,
                              '/connect_device',
                            ); // اختياري
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isConnected
                                      ? Icons.check_circle
                                      : Icons.error,
                                  color: isConnected
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isConnected ? "Connected" : "Not Connected",
                                  style: const TextStyle(
                                    color: Color(0xFF0A5C71),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 🔵 Refresh + Button
                        Row(
                          children: [
                            // 🔄 Refresh (رجعناه شكله القديم)
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
                                  Navigator.pushNamed(context, '/refresh');
                                },
                              ),
                            ),

                            const SizedBox(width: 10),

                            // 🔘 Connect / Change
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Builder(
                      builder: (context) {
                        final user = FirebaseAuth.instance.currentUser;

                        if (user == null) {
                          return const Text("No user");
                        }

                        return StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            final data =
                                snapshot.data?.data() as Map<String, dynamic>?;

                            final fullName = data?['name'] ?? "User";
                            final firstName = fullName.split(" ").first;

                            return Text(
                              "Hello, $firstName!",
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0A5C71),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Real-time water status',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(
                              0xFF0A5C71,
                            ).withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Main Quality Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
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
                                    getTitle(),
                                    style: TextStyle(
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
                                displayScore.toStringAsFixed(0),
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
                                  isSafe ? Icons.check_circle : Icons.warning,
                                  color: getMainColor(),
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Status: ${getStatusText()}',
                                  style: TextStyle(
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
                    ),
                    const SizedBox(height: 24),

                    const SizedBox(height: 16),

                    // 🔥 هنا نحط الكود الجديد
                    isConnected
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildSensorCard(
                                      'pH Level',
                                      ph.toStringAsFixed(2),
                                      getPhStatus(ph),
                                      Icons.water_drop,
                                      getPhColor(ph),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildSensorCard(
                                      'Temperature',
                                      '${temp.toStringAsFixed(1)}°C',
                                      getTempStatus(temp),
                                      Icons.thermostat,
                                      getTempColor(temp),
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
                                      '$tds ppm',
                                      getTdsStatus(tds.toDouble()),
                                      Icons.waves,
                                      getTdsColor(tds.toDouble()),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildSensorCard(
                                      'Turbidity',
                                      '${turb.toStringAsFixed(2)} NTU',
                                      getTurbidityStatus(turb),
                                      Icons.bolt,
                                      getTurbidityColor(turb),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : StreamBuilder<Map<String, dynamic>?>(
                            stream: getLatestReading(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Text("No data yet");
                              }

                              final data = snapshot.data!;

                              double ph = (data['ph'] ?? -1).toDouble();
                              double temp = (data['temp'] ?? -1).toDouble();
                              double tds = (data['tds'] ?? -1).toDouble();
                              double turb = (data['turbidity'] ?? -1)
                                  .toDouble();

                              var result = WaterQualityModel.predict(
                                ph: ph,
                                tds: tds,
                                temperature: temp,
                                turbidity: turb,
                              );
                              double scoreFB = result['confidence'] * 100;
                              String statusFB = result['status'];
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted) {
                                  setState(() {
                                    displayScore = scoreFB;
                                    displayStatus = statusFB;
                                  });
                                }
                              });
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildSensorCard(
                                          'pH Level',
                                          '$ph',
                                          getPhStatus(ph.toDouble()),
                                          Icons.water_drop,
                                          const Color(0xFF3BA5F3),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildSensorCard(
                                          'Temperature',
                                          '$temp°C',
                                          getTempStatus(temp.toDouble()),
                                          Icons.thermostat,
                                          const Color(0xFFFF9800),
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
                                          '$tds ppm',
                                          getTdsStatus(tds.toDouble()),
                                          Icons.waves,
                                          const Color(0xFF9C27B0),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildSensorCard(
                                          'Turbidity',
                                          '$turb NTU',
                                          getTurbidityStatus(turb.toDouble()),
                                          Icons.bolt,
                                          const Color(0xFF795548),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                    const SizedBox(height: 100), // Space for bottom nav
                  ],
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
    Color iconColor, // 👈 fixed icon color
  ) {
    // 🔥 NEW: determine status color from text
    Color statusColor;

    if (status.toLowerCase().contains('optimal') ||
        status.toLowerCase().contains('cool') ||
        status.toLowerCase().contains('excellent') ||
        status.toLowerCase().contains('very clear')) {
      statusColor = Colors.green;
    } else if (status.toLowerCase().contains('moderate') ||
        status.toLowerCase().contains('normal')) {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ ICON (FIXED COLOR)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF0A5C71).withOpacity(0.6),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          // 🔥 VALUE (status color)
          Text(
            value,
            style: TextStyle(
              color: Color(0xFF0A5C71),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 4),

          // 🔥 STATUS (status color)
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
