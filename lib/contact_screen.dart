import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        backgroundColor: const Color(0xFF0A5C71),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildItem(Icons.email, "Email", "aquavision@gmail.com"),
            _buildItem(Icons.phone, "Phone", "+20 123 456 789"),
            _buildItem(Icons.language, "Website", "www.aquavision.com"),
            _buildItem(Icons.facebook, "Facebook", "AquaVision"),
            _buildItem(Icons.camera_alt, "Instagram", "@aquavision"),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
