import 'package:flutter/material.dart';
import 'widgets/custom_bottom_nav.dart';
import 'sensors_screen.dart';
import 'referesh.dart';
import 'history_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class SensorDetailScreen extends StatelessWidget {
  const SensorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> sensor =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {
          'name': 'Sensor',
          'value': '0',
          'unit': '',
          'status': 'Unknown',
          'color': const Color(0xFF0A5C71),
          'icon': Icons.sensors,
          'desc': 'Sensor details',
        };

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
                color: (sensor['color'] as Color).withValues(alpha: 0.2),
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
                            builder: (context) => const SensorsScreen(),
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Text(
                        sensor['name'] as String,
                        style: const TextStyle(
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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Main Value Card
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(40),
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
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: (sensor['color'] as Color).withValues(
                                    alpha: 0.1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  sensor['icon'] as IconData,
                                  color: sensor['color'] as Color,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  StreamBuilder<List<Map<String, dynamic>>>(
                                    stream: getHistory(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return const Text(
                                          "0",
                                          style: TextStyle(
                                            fontSize: 64,
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xFF0A5C71),
                                          ),
                                        );
                                      }

                                      final last = snapshot.data!.last;

                                      double value;

                                      if (sensor['id'] == 'ph') {
                                        value = (last['ph'] ?? 0).toDouble();
                                      } else if (sensor['id'] == 'temp') {
                                        value = (last['temp'] ?? 0).toDouble();
                                      } else if (sensor['id'] == 'tds') {
                                        value = (last['tds'] ?? 0).toDouble();
                                      } else {
                                        value = (last['turbidity'] ?? 0)
                                            .toDouble();
                                      }

                                      return Text(
                                        value.toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 64,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF0A5C71),
                                        ),
                                      );
                                    },
                                  ),
                                  if ((sensor['unit'] as String)
                                      .isNotEmpty) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      sensor['unit'] as String,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(
                                          0xFF0A5C71,
                                        ).withValues(alpha: 0.5),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: (sensor['color'] as Color).withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  sensor['status'] as String,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: sensor['color'] as Color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Graph Card
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
                              Text(
                                'Historical Data',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(
                                    0xFF0A5C71,
                                  ).withValues(alpha: 0.4),
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
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
                                            .take(10)
                                            .toList()
                                            .toList();

                                        List<FlSpot> spots = [];

                                        for (
                                          int i = 0;
                                          i < readings.length;
                                          i++
                                        ) {
                                          double value;

                                          if (sensor['id'] == 'ph') {
                                            value = (readings[i]['ph'] ?? 0)
                                                .toDouble();
                                          } else if (sensor['id'] == 'temp') {
                                            value = (readings[i]['temp'] ?? 0)
                                                .toDouble();
                                          } else if (sensor['id'] == 'tds') {
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

                                        // 🔥 ديناميك رينج
                                        double minY =
                                            spots
                                                .map((e) => e.y)
                                                .reduce(
                                                  (a, b) => a < b ? a : b,
                                                ) -
                                            1;
                                        double maxY =
                                            spots
                                                .map((e) => e.y)
                                                .reduce(
                                                  (a, b) => a > b ? a : b,
                                                ) +
                                            1;

                                        return SizedBox(
                                          height: 160,
                                          child: LineChart(
                                            LineChartData(
                                              minY: minY,
                                              maxY: maxY,

                                              gridData: FlGridData(
                                                show: true,
                                                drawVerticalLine: false,
                                                horizontalInterval:
                                                    (maxY - minY) / 4,
                                                getDrawingHorizontalLine:
                                                    (value) {
                                                      return FlLine(
                                                        color:
                                                            const Color(
                                                              0xFF0A5C71,
                                                            ).withValues(
                                                              alpha: 0.05,
                                                            ),
                                                        strokeWidth: 1,
                                                      );
                                                    },
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
                                                  curveSmoothness: 0.5,

                                                  gradient: LinearGradient(
                                                    colors: [
                                                      (sensor['color']
                                                          as Color),
                                                      (sensor['color'] as Color)
                                                          .withValues(
                                                            alpha: 0.4,
                                                          ),
                                                    ],
                                                  ),

                                                  barWidth: 5,

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
                                                            color: Colors.white,
                                                            strokeWidth: 2,
                                                            strokeColor:
                                                                sensor['color']
                                                                    as Color,
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
                                                        (sensor['color']
                                                                as Color)
                                                            .withValues(
                                                              alpha: 0.3,
                                                            ),
                                                        (sensor['color']
                                                                as Color)
                                                            .withValues(
                                                              alpha: 0.05,
                                                            ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // Graph curve (mock)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
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

                        const SizedBox(height: 32),

                        // Description Card
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
                              Text(
                                'About ${sensor['name']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(
                                    0xFF0A5C71,
                                  ).withValues(alpha: 0.4),
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                sensor['desc'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0A5C71),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(current: 'sensors'),
    );
  }
}
