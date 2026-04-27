import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ScanDevicesScreen extends StatefulWidget {
  const ScanDevicesScreen({super.key});

  @override
  State<ScanDevicesScreen> createState() => _ScanDevicesScreenState();
}

class _ScanDevicesScreenState extends State<ScanDevicesScreen>
    with WidgetsBindingObserver {
  List<WiFiAccessPoint> networks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    scanWifi();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 🔁 لما يرجع من settings
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkConnection(); // 🔥 يدخل Analyze لو متصل
      scanWifi(); // تحديث القائمة
    }
  }

  // ✅ تحقق من الاتصال
  Future<void> checkConnection() async {
    final info = NetworkInfo();
    String? wifiName;

    try {
      wifiName = await info.getWifiName();
    } catch (e) {
      debugPrint("Error: $e");
    }

    if (!mounted) return;

    if (wifiName != null && wifiName.isNotEmpty) {
      wifiName = wifiName.replaceAll('"', '');

      Navigator.pushReplacementNamed(context, '/analyzing_water');
    }
  }

  // 🔍 Scan WiFi
  Future<void> scanWifi() async {
    setState(() => isLoading = true);

    var status = await Permission.location.request();

    if (!status.isGranted) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final canScan = await WiFiScan.instance.canStartScan();

      if (canScan != CanStartScan.yes) {
        setState(() => isLoading = false);
        return;
      }

      await WiFiScan.instance.startScan();
      final results = await WiFiScan.instance.getScannedResults();

      if (!mounted) return;

      setState(() {
        networks = results;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  // 📡 فتح WiFi settings
  void openWifiSettings() {
    AppSettings.openAppSettings(type: AppSettingsType.wifi);
  }

  // 📱 عنصر الشبكة
  Widget buildWifiTile(WiFiAccessPoint wifi) {
    final ssid = wifi.ssid;

    return GestureDetector(
      onTap: ssid.isEmpty
          ? null
          : () {
              openWifiSettings(); // 🔥 يفتح إعدادات الواي فاي
            },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF0A5C71), width: 1.2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.wifi, color: Color(0xFF0A5C71)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                ssid.isEmpty ? "Unknown" : ssid,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A5C71),
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  // 🧱 UI
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
              const SizedBox(height: 10),

              // 🔹 Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
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
                        "Scan For\nDevices",
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

              const SizedBox(height: 8),

              const Text(
                "Tap a network to connect",
                style: TextStyle(fontSize: 16, color: Color(0xFF0A5C71)),
              ),

              const SizedBox(height: 16),

              // 🔹 الشبكات
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : networks.isEmpty
                      ? const Center(
                          child: Text(
                            "No networks found",
                            style: TextStyle(color: Color(0xFF0A5C71)),
                          ),
                        )
                      : ListView.builder(
                          itemCount: networks.length,
                          itemBuilder: (context, index) {
                            return buildWifiTile(networks[index]);
                          },
                        ),
                ),
              ),

              // 🔹 Rescan
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: scanWifi,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFF0A5C71),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Rescan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0A5C71),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
