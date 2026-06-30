import 'package:flutter/material.dart';

/// ==================== pH ====================

String getPhStatus(double ph) {
  if (ph <= 0 || ph > 14) return "Check Sensor";

  if (ph >= 6.5 && ph <= 8) return "Optimal";
  if ((ph >= 6 && ph < 6.5) || (ph > 8 && ph <= 8.5)) return "Slightly Off";
  return "Danger";
}

Color getPhColor(double ph) {
  if (ph <= 0 || ph > 14) return Colors.red;

  if (ph >= 6.5 && ph <= 8) return Colors.green;
  if ((ph >= 6 && ph < 6.5) || (ph > 8 && ph <= 8.5)) return Colors.orange;
  return Colors.red;
}

/// ==================== Temperature ====================

String getTempStatus(double temp) {
  if (temp <= 0 || temp > 100) return "Check Sensor";

  if (temp <= 25) return "Cool";
  if (temp <= 30) return "Normal";
  if (temp <= 35) return "Warm";
  return "Hot";
}

Color getTempColor(double temp) {
  if (temp <= 0 || temp > 100) return Colors.red;

  if (temp <= 30) return Colors.green;
  if (temp <= 35) return Colors.orange;
  return Colors.red;
}

/// ==================== TDS ====================

String getTdsStatus(double tds) {
  if (tds == 0) return "Check Sensor";
  if (tds <= 150) return "Excellent";
  if (tds <= 300) return "Good";
  if (tds <= 500) return "Poor";
  return "Unsafe";
}

Color getTdsColor(double tds) {
  if (tds == 0) return Colors.red;
  if (tds <= 300) return Colors.green;
  if (tds <= 500) return Colors.orange;
  return Colors.red;
}

/// ==================== Turbidity ====================
String getTurbidityStatus(double turbidity) {
  if (turbidity <= 0 || turbidity > 1000) return "Check Sensor";

  if (turbidity <= 1) return "Very Clear";
  if (turbidity <= 5) return "Clear";
  if (turbidity <= 10) return "Cloudy";
  return "Dirty";
}

Color getTurbidityColor(double turbidity) {
  if (turbidity <= 0 || turbidity > 1000) return Colors.red;

  if (turbidity <= 5) return Colors.green;
  if (turbidity <= 10) return Colors.orange;
  return Colors.red;
}
