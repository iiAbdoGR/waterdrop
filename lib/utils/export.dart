import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> exportData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('readings')
      .get();

  // ignore: unused_local_variable
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

Future<void> exportChartAsPDF(GlobalKey chartKey) async {
  RenderRepaintBoundary boundary =
      chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  Uint8List pngBytes = byteData!.buffer.asUint8List();

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.Text("Water Report"),
          pw.SizedBox(height: 20),
          pw.Image(pw.MemoryImage(pngBytes)),
        ],
      ),
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}
