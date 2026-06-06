import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// 🔥 مهم: استورد الموديل بتاعك
import 'package:waterdrop/utils/water_quality.dart';

Future<void> exportAllDataForML() async {
  final snapshot = await FirebaseFirestore.instance
      .collectionGroup('readings')
      .get();

  String csv = "ph,temp,tds,turbidity,label\n";

  for (var doc in snapshot.docs) {
    final data = doc.data();

    final result = WaterQualityModel.predict(
      ph: (data['ph'] ?? 0).toDouble(),
      tds: (data['tds'] ?? 0).toDouble(),
      temperature: (data['temp'] ?? 0).toDouble(),
      turbidity: (data['turbidity'] ?? 0).toDouble(),
    );

    int label = result['potable'] == true ? 1 : 0;

    csv +=
        "${data['ph']},"
        "${data['temp']},"
        "${data['tds']},"
        "${data['turbidity']},"
        "$label\n";
  }

  final directory = await getTemporaryDirectory();
  final path = "${directory.path}/ml_dataset.csv";

  final file = File(path);
  await file.writeAsString(csv);

  await Share.shareXFiles([XFile(path)], text: "ML Dataset");
}

Future<void> exportData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('readings')
      .get();

  // 🔥 ضفنا label
  String csv = "ph,temp,tds,turbidity,label,timestamp\n";

  for (var doc in snapshot.docs) {
    final data = doc.data();

    // 🔥 استخدم الموديل
    final result = WaterQualityModel.predict(
      ph: (data['ph'] ?? 0).toDouble(),
      tds: (data['tds'] ?? 0).toDouble(),
      temperature: (data['temp'] ?? 0).toDouble(),
      turbidity: (data['turbidity'] ?? 0).toDouble(),
    );

    // 🔥 تحويل لـ 1 أو 0
    int label = result['potable'] == true ? 1 : 0;

    csv +=
        "${data['ph']},"
        "${data['temp']},"
        "${data['tds']},"
        "${data['turbidity']},"
        "$label,"
        "${data['timestamp']}\n";
  }

  // 🔥 حفظ الملف
  final directory = await getTemporaryDirectory();
  final path = "${directory.path}/water_data.csv";

  final file = File(path);
  await file.writeAsString(csv);

  // 🔥 مشاركة / تحميل
  await Share.shareXFiles([XFile(path)], text: "Water Data Report");
}
