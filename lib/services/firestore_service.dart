import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Get the current user's ID
  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  /// Get the current user's display name from Firebase Auth
  String get currentUserName {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.displayName != null && user.displayName!.isNotEmpty) {
      return user.displayName!.split(' ').first; // First name only
    }
    return 'User';
  }

  // ─── DEVICE OPERATIONS ───────────────────────────────────────────

  /// Stream of devices for the current user
  Stream<QuerySnapshot> getDevicesStream() {
    final uid = currentUserId;
    if (uid == null) {
      debugPrint('FirestoreService: No user logged in, cannot get devices');
      return const Stream.empty();
    }
    return _db
        .collection('users')
        .doc(uid)
        .collection('devices')
        .snapshots();
  }

  /// Get device overview data (score, condition, etc.)
  Stream<DocumentSnapshot> getDeviceOverviewStream(String deviceId) {
    final uid = currentUserId;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('users')
        .doc(uid)
        .collection('devices')
        .doc(deviceId)
        .snapshots();
  }

  // ─── SENSOR OPERATIONS ───────────────────────────────────────────

  /// Stream of all sensors for a device
  Stream<QuerySnapshot> getSensorsStream(String deviceId) {
    final uid = currentUserId;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('users')
        .doc(uid)
        .collection('devices')
        .doc(deviceId)
        .collection('sensors')
        .snapshots();
  }

  /// Get a single sensor's data
  Stream<DocumentSnapshot> getSensorStream(String deviceId, String sensorId) {
    final uid = currentUserId;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('users')
        .doc(uid)
        .collection('devices')
        .doc(deviceId)
        .collection('sensors')
        .doc(sensorId)
        .snapshots();
  }

  /// Get sensor history (sub-collection of readings)
  Stream<QuerySnapshot> getSensorHistoryStream(
    String deviceId,
    String sensorId, {
    int limit = 20,
  }) {
    final uid = currentUserId;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('users')
        .doc(uid)
        .collection('devices')
        .doc(deviceId)
        .collection('sensors')
        .doc(sensorId)
        .collection('history')
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }

  // ─── SEED DATA ───────────────────────────────────────────────────

  /// Seeds initial test data for the current user.
  /// Call this once to populate Firestore with sample data.
  Future<void> seedInitialData() async {
    final uid = currentUserId;
    if (uid == null) return;

    final userRef = _db.collection('users').doc(uid);

    // Check if data already exists
    final devicesSnapshot = await userRef.collection('devices').limit(1).get();
    if (devicesSnapshot.docs.isNotEmpty) {
      return; // Data already seeded
    }

    // Save user display name
    await userRef.set({
      'displayName': currentUserName,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // Create devices
    final devices = {
      'device_a': 'Device A',
      'device_b': 'Device B',
      'device_c': 'Device C',
    };

    for (final entry in devices.entries) {
      final deviceRef = userRef.collection('devices').doc(entry.key);

      await deviceRef.set({
        'name': entry.value,
        'lastUpdated': FieldValue.serverTimestamp(),
        'overallScore': 62,
        'condition': 'Excellent Condition',
        'safeForUse': true,
      });

      // Create sensors for each device
      final sensors = [
        {
          'id': 'ph',
          'name': 'pH Level',
          'value': '7.2',
          'unit': '',
          'status': 'Optimal',
          'desc': 'Measures the acidity or alkalinity of the water. The pH scale ranges from 0 to 14, with 7 being neutral. Drinking water should have a pH between 6.5 and 8.5.',
        },
        {
          'id': 'temp',
          'name': 'Temperature',
          'value': '24.5',
          'unit': '°C',
          'status': 'Normal',
          'desc': 'Current water temperature. Ideal drinking water temperature ranges from 20°C to 25°C. Higher temperatures can promote bacterial growth.',
        },
        {
          'id': 'tds',
          'name': 'TDS',
          'value': '120',
          'unit': 'ppm',
          'status': 'Good',
          'desc': 'Total Dissolved Solids measures the combined content of all organic and inorganic substances in water. Ideal TDS for drinking water is below 300 ppm.',
        },
        {
          'id': 'turbidity',
          'name': 'Turbidity',
          'value': '1.5',
          'unit': 'NTU',
          'status': 'Clear',
          'desc': 'Turbidity measures the clarity of water. Lower values indicate clearer water. Drinking water should have turbidity below 4 NTU.',
        },
      ];

      for (final sensor in sensors) {
        final sensorRef = deviceRef.collection('sensors').doc(sensor['id'] as String);
        await sensorRef.set({
          'name': sensor['name'],
          'value': sensor['value'],
          'unit': sensor['unit'],
          'status': sensor['status'],
          'desc': sensor['desc'],
        });

        // Create history entries for each sensor
        final now = DateTime.now();
        final historyValues = _generateHistoryValues(sensor['id'] as String);

        for (int i = 0; i < historyValues.length; i++) {
          await sensorRef.collection('history').add({
            'value': historyValues[i],
            'timestamp': Timestamp.fromDate(
              now.subtract(Duration(hours: (historyValues.length - 1 - i) * 4)),
            ),
          });
        }
      }
    }
  }

  /// Generate sample history values based on sensor type
  List<double> _generateHistoryValues(String sensorId) {
    switch (sensorId) {
      case 'ph':
        return [7.0, 7.1, 7.3, 7.2, 7.4, 7.2];
      case 'temp':
        return [23.0, 24.0, 25.5, 24.5, 23.5, 24.5];
      case 'tds':
        return [115.0, 118.0, 125.0, 120.0, 122.0, 120.0];
      case 'turbidity':
        return [1.8, 1.6, 1.4, 1.5, 1.3, 1.5];
      default:
        return [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    }
  }
}
