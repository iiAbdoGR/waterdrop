import 'package:flutter/material.dart';
import 'widgets/custom_bottom_nav.dart';
import 'home_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedTab = 'pH';

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
                color: const Color(0xFF4ECDC4).withOpacity(0.2),
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
                color: const Color(0xFFFFE66D).withOpacity(0.2),
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
                              color: Colors.black.withOpacity(0.1),
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
                                  : Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : const Color(0xFF0A5C71).withOpacity(0.1),
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF0A5C71,
                                        ).withOpacity(0.3),
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
                                    : const Color(0xFF0A5C71).withOpacity(0.5),
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
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
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
                                          ).withOpacity(0.4),
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          const Text(
                                            '7.2',
                                            style: TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w900,
                                              color: Color(0xFF0A5C71),
                                              letterSpacing: -2,
                                            ),
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
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF4ECDC4,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          size: 14,
                                          color: Color(0xFF4ECDC4),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          '2.4%',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF4ECDC4),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                          ).withOpacity(0.05),
                                        ),
                                      ),
                                    ),
                                    // Graph curve (mock)
                                    CustomPaint(
                                      size: const Size(double.infinity, 160),
                                      painter: GraphPainter(),
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
                                              ).withOpacity(0.4),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),
                        Text(
                          'Last updated : 15 minutes ago',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0A5C71).withOpacity(0.6),
                          ),
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
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(
                                        0xFF0A5C71,
                                      ).withOpacity(0.1),
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
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF0A5C71,
                                    ).withOpacity(0.1),
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
