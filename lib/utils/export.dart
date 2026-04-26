import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
