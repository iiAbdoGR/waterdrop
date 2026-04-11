import 'package:flutter/material.dart';

class ScanDevicesScreen extends StatelessWidget {
  const ScanDevicesScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Scan For\nDevices',
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
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: const Color(0xFF0A5C71).withValues(alpha: 0.2),
                    ),
                  ),
                ),
                child: const Text(
                  'Scanning for nearby devices...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0A5C71),
                    fontFamily: 'Georgia',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Available Devices',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0A5C71),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    _buildDeviceCard(context, 'Device A', isSelected: true),
                    const SizedBox(height: 12),
                    _buildDeviceCard(context, 'Device B'),
                    const SizedBox(height: 12),
                    _buildDeviceCard(context, 'Device C'),
                    const SizedBox(height: 12),
                    _buildAddButton(),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF0A5C71),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A5C71),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(
    BuildContext context,
    String name, {
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/analyzing_water');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9CE3F5) : Colors.transparent,
          border: Border.all(color: const Color(0xFF0A5C71), width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(Icons.lock_outline, color: Color(0xFF0A5C71), size: 20),
            const SizedBox(width: 12),
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A5C71),
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check, color: Color(0xFF0A5C71), size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: const Color(0xFF0A5C71), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: const [
          Icon(Icons.add, color: Color(0xFF0A5C71), size: 24),
          SizedBox(width: 12),
          Text(
            'Add new',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A5C71),
            ),
          ),
        ],
      ),
    );
  }
}
