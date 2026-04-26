import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waterdrop/utils/export.dart';
import 'widgets/custom_bottom_nav.dart';
import 'home_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

Stream<List<Map<String, dynamic>>> getHistory() {
  final user = FirebaseAuth.instance.currentUser;
  final GlobalKey chartKey = GlobalKey();
  if (user == null) return const Stream.empty();

  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('readings')
      .orderBy('timestamp', descending: false)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
}

Future<void> exportData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('readings')
      .get();

  String csv = "ph,temp,tds,turbidity,timestamp\n";

  for (var doc in snapshot.docs) {
    final data = doc.data();

    csv +=
        "${data['ph']},"
        "${data['temp']},"
        "${data['tds']},"
        "${data['turbidity']},"
        "${data['timestamp']}\n";
  }
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedTab = 'pH';
  final GlobalKey chartKey = GlobalKey();

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
                        'History',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0A5C71),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 40),
                      /*Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha:0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        /*child: IconButton(
                          icon: const Icon(Icons.refresh, size: 20, color: Color(0xFF0A5C71)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RefreshScreen(),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                        ),*/
                      ),*/
                    ],
                  ),
                ),

                // Tab Bar
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Row(
                    children: ['pH', 'Temperature', 'TDS', 'Turbidity'].map((
                      tab,
                    ) {
                      final isSelected = _selectedTab == tab;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTab = tab),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF0A5C71)
                                  : Colors.white.withValues(alpha: 0.6),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : const Color(
                                        0xFF0A5C71,
                                      ).withValues(alpha: 0.1),
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF0A5C71,
                                        ).withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Text(
                              tab,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(
                                        0xFF0A5C71,
                                      ).withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Main Graph Card
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Average $_selectedTab',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900,
                                          color: const Color(
                                            0xFF0A5C71,
                                          ).withValues(alpha: 0.4),
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          StreamBuilder<
                                            List<Map<String, dynamic>>
                                          >(
                                            stream: getHistory(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return const Text(
                                                  "0",
                                                  style: TextStyle(
                                                    fontSize: 48,
                                                    fontWeight: FontWeight.w900,
                                                    color: Color(0xFF0A5C71),
                                                  ),
                                                );
                                              }

                                              final readings = snapshot.data!;

                                              double avg = 0;

                                              for (var r in readings) {
                                                if (_selectedTab == 'pH') {
                                                  avg += (r['ph'] ?? 0);
                                                } else if (_selectedTab ==
                                                    'Temperature') {
                                                  avg += (r['temp'] ?? 0);
                                                } else if (_selectedTab ==
                                                    'TDS') {
                                                  avg += (r['tds'] ?? 0);
                                                } else {
                                                  avg += (r['turbidity'] ?? 0);
                                                }
                                              }

                                              avg = avg / readings.length;

                                              return Text(
                                                avg.toStringAsFixed(1),
                                                style: const TextStyle(
                                                  fontSize: 48,
                                                  fontWeight: FontWeight.w900,
                                                  color: Color(0xFF0A5C71),
                                                  letterSpacing: -2,
                                                ),
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            _selectedTab == 'Temperature'
                                                ? '°C'
                                                : _selectedTab == 'TDS'
                                                ? 'ppm'
                                                : _selectedTab == 'Turbidity'
                                                ? 'NTU'
                                                : '',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1CA3C6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  StreamBuilder<List<Map<String, dynamic>>>(
                                    stream: getHistory(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData ||
                                          snapshot.data!.length < 2) {
                                        return const SizedBox(); // مفيش بيانات كفاية
                                      }

                                      final readings = snapshot.data!;
                                      final last = readings.last;
                                      final prev =
                                          readings[readings.length - 2];

                                      double current;
                                      double previous;

                                      if (_selectedTab == 'pH') {
                                        current = (last['ph'] ?? 0).toDouble();
                                        previous = (prev['ph'] ?? 0).toDouble();
                                      } else if (_selectedTab ==
                                          'Temperature') {
                                        current = (last['temp'] ?? 0)
                                            .toDouble();
                                        previous = (prev['temp'] ?? 0)
                                            .toDouble();
                                      } else if (_selectedTab == 'TDS') {
                                        current = (last['tds'] ?? 0).toDouble();
                                        previous = (prev['tds'] ?? 0)
                                            .toDouble();
                                      } else {
                                        current = (last['turbidity'] ?? 0)
                                            .toDouble();
                                        previous = (prev['turbidity'] ?? 0)
                                            .toDouble();
                                      }

                                      double percent = 0;
                                      if (previous != 0) {
                                        percent =
                                            ((current - previous) / previous) *
                                            100;
                                      }

                                      final isUp = percent >= 0;

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isUp
                                              ? const Color(
                                                  0xFF4ECDC4,
                                                ).withValues(alpha: 0.1)
                                              : Colors.red.withValues(
                                                  alpha: 0.1,
                                                ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              isUp
                                                  ? Icons.arrow_upward
                                                  : Icons.arrow_downward,
                                              size: 14,
                                              color: isUp
                                                  ? const Color(0xFF4ECDC4)
                                                  : Colors.red,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${percent.abs().toStringAsFixed(1)}%',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: isUp
                                                    ? const Color(0xFF4ECDC4)
                                                    : Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),

                              // Graph Placeholder
                              SizedBox(
                                height: 160,
                                child: Stack(
                                  children: [
                                    // Grid lines
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(
                                        4,
                                        (index) => Container(
                                          height: 1,
                                          color: const Color(
                                            0xFF0A5C71,
                                          ).withValues(alpha: 0.05),
                                        ),
                                      ),
                                    ),
                                    // Graph curve (mock)
                                    StreamBuilder<List<Map<String, dynamic>>>(
                                      stream: getHistory(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return const Center(
                                            child: Text("No data"),
                                          );
                                        }

                                        final readings = snapshot.data!
                                            .take(6)
                                            .toList();
                                        Color chartColor;

                                        if (_selectedTab == 'pH') {
                                          chartColor = const Color(0xFF4ECDC4);
                                        } else if (_selectedTab ==
                                            'Temperature') {
                                          chartColor = const Color(0xFFFF9F1C);
                                        } else if (_selectedTab == 'TDS') {
                                          chartColor = const Color(0xFF1CA3C6);
                                        } else {
                                          chartColor = const Color(0xFF9D4EDD);
                                        }
                                        double minY = readings
                                            .map(
                                              (r) => (_selectedTab == 'pH'
                                                  ? r['ph']
                                                  : _selectedTab ==
                                                        'Temperature'
                                                  ? r['temp']
                                                  : _selectedTab == 'TDS'
                                                  ? r['tds']
                                                  : r['turbidity']),
                                            )
                                            .reduce((a, b) => a < b ? a : b)
                                            .toDouble();

                                        double maxY = readings
                                            .map(
                                              (r) => (_selectedTab == 'pH'
                                                  ? r['ph']
                                                  : _selectedTab ==
                                                        'Temperature'
                                                  ? r['temp']
                                                  : _selectedTab == 'TDS'
                                                  ? r['tds']
                                                  : r['turbidity']),
                                            )
                                            .reduce((a, b) => a > b ? a : b)
                                            .toDouble();

                                        minY -= 0.5;
                                        maxY += 0.5;

                                        if (minY == maxY) {
                                          minY -= 1;
                                          maxY += 1;
                                        }

                                        List<FlSpot> spots = [];

                                        for (
                                          int i = 0;
                                          i < readings.length;
                                          i++
                                        ) {
                                          double value;

                                          if (_selectedTab == 'pH') {
                                            value = (readings[i]['ph'] ?? 0)
                                                .toDouble();
                                          } else if (_selectedTab ==
                                              'Temperature') {
                                            value = (readings[i]['temp'] ?? 0)
                                                .toDouble();
                                          } else if (_selectedTab == 'TDS') {
                                            value = (readings[i]['tds'] ?? 0)
                                                .toDouble();
                                          } else {
                                            value =
                                                (readings[i]['turbidity'] ?? 0)
                                                    .toDouble();
                                          }

                                          spots.add(
                                            FlSpot(i.toDouble(), value),
                                          );
                                        }

                                        return RepaintBoundary(
                                          key: chartKey,
                                          child: SizedBox(
                                            height: 160,

                                            child: LineChart(
                                              LineChartData(
                                                minY: minY,
                                                maxY: maxY,
                                                gridData: FlGridData(
                                                  show: true,
                                                ),
                                                titlesData: FlTitlesData(
                                                  show: false,
                                                ),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                lineBarsData: [
                                                  LineChartBarData(
                                                    spots: spots,
                                                    isCurved: true,
                                                    curveSmoothness: 0.4,

                                                    gradient: LinearGradient(
                                                      colors: [
                                                        chartColor,
                                                        chartColor.withValues(
                                                          alpha: 0.2,
                                                        ),
                                                      ],
                                                    ),

                                                    barWidth: 4,

                                                    dotData: FlDotData(
                                                      show: true,
                                                      getDotPainter:
                                                          (
                                                            spot,
                                                            percent,
                                                            bar,
                                                            index,
                                                          ) {
                                                            return FlDotCirclePainter(
                                                              radius: 4,
                                                              color:
                                                                  Colors.white,
                                                              strokeWidth: 2,
                                                              strokeColor:
                                                                  chartColor,
                                                            );
                                                          },
                                                    ),

                                                    belowBarData: BarAreaData(
                                                      show: true,
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                        colors: [
                                                          chartColor.withValues(
                                                            alpha: 0.3,
                                                          ),
                                                          chartColor.withValues(
                                                            alpha: 0.05,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              // X-Axis Labels
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:
                                    [
                                          '8 AM',
                                          '12 PM',
                                          '4 PM',
                                          '8 PM',
                                          '12 AM',
                                          '4 AM',
                                        ]
                                        .map(
                                          (time) => Text(
                                            time,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: const Color(
                                                0xFF0A5C71,
                                              ).withValues(alpha: 0.4),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                        StreamBuilder<List<Map<String, dynamic>>>(
                          stream: getHistory(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text("No updates yet");
                            }

                            final readings = snapshot.data!;
                            final last = readings.last;

                            final timestamp = last['timestamp'] as Timestamp?;
                            if (timestamp == null) {
                              return const Text("Updating...");
                            }

                            final now = DateTime.now();
                            final diff = now.difference(timestamp.toDate());

                            String text;

                            if (diff.inSeconds < 60) {
                              text = "just now";
                            } else if (diff.inMinutes < 60) {
                              final m = diff.inMinutes;
                              text = m == 1 ? "1 minute ago" : "$m minutes ago";
                            } else if (diff.inHours < 24) {
                              final h = diff.inHours;
                              text = h == 1 ? "1 hour ago" : "$h hours ago";
                            } else {
                              final d = diff.inDays;
                              text = d == 1 ? "1 day ago" : "$d days ago";
                            }

                            return Text(
                              "Last updated: $text",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(
                                  0xFF0A5C71,
                                ).withValues(alpha: 0.6),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () async {
                                  await Navigator.pushNamed(
                                    context,
                                    '/refresh',
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF0A5C71,
                                      ).withValues(alpha: 0.1),
                                    ),
                                  ),
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: Color(0xFF0A5C71),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Refresh',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0A5C71),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () async {
                                  await exportChartAsPDF(chartKey);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF0A5C71,
                                      ).withValues(alpha: 0.1),
                                    ),
                                  ),
                                  child: const Column(
                                    children: [
                                      Icon(
                                        Icons.upload,
                                        color: Color(0xFF0A5C71),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Export',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0A5C71),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
      bottomNavigationBar: const CustomBottomNav(current: 'history'),
    );
  }
}

class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1CA3C6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.125,
      size.height * 0.7,
      size.width * 0.25,
      size.height * 0.75,
    );
    path.quadraticBezierTo(
      size.width * 0.375,
      size.height * 0.8,
      size.width * 0.5,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.625,
      size.height * 0.4,
      size.width * 0.75,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.875,
      size.height * 1.2,
      size.width,
      size.height * 0.5,
    );

    canvas.drawPath(path, paint);

    // Draw points
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF1CA3C6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.25, size.height * 0.75),
      Offset(size.width * 0.5, size.height * 0.6),
      Offset(size.width * 0.75, size.height * 0.8),
      Offset(size.width, size.height * 0.5),
    ];

    for (var point in points) {
      canvas.drawCircle(point, 4, pointPaint);
      canvas.drawCircle(point, 4, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
