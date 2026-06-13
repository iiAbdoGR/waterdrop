class WaterQualityModel {
  static Map<String, dynamic> predict({
    required double ph,
    required double tds,
    required double temperature,
    required double turbidity,
  }) {
    String status;
    bool potable = true;

    // 🌳 Level 1: pH
    if (ph >= 6.5 && ph <= 8.5) {
      // 🌳 Level 2: Temperature
      if (temperature >= 22 && temperature <= 27) {
        // 🌳 Level 3: TDS
        if (tds < 300) {
          // 🌳 Level 4: Turbidity
          if (turbidity <= 1) {
            status = "Safe";
          } else if (turbidity <= 3) {
            status = "Safe";
          } else if (turbidity <= 5) {
            status = "Caution";
          } else if (turbidity <= 8) {
            status = "Caution";
          } else {
            status = "Dangerous";
            potable = false;
          }
        } else if (tds < 500) {
          if (turbidity <= 3) {
            status = "Caution";
          } else if (turbidity <= 5) {
            status = "Caution";
          } else {
            status = "Dangerous";
            potable = false;
          }
        } else if (tds < 800) {
          if (turbidity <= 3) {
            status = "Caution";
          } else {
            status = "Dangerous";
            potable = false;
          }
        } else {
          status = "Dangerous";
          potable = false;
        }
      }
      // 🟡 Temperature (20–30)
      else if (temperature >= 20 && temperature <= 30) {
        if (tds < 300) {
          if (turbidity <= 3) {
            status = "Safe";
          } else if (turbidity <= 5) {
            status = "Caution";
          } else {
            status = "Dangerous";
            potable = false;
          }
        } else if (tds < 500) {
          if (turbidity <= 5) {
            status = "Caution";
          } else {
            status = "Dangerous";
            potable = false;
          }
        } else {
          status = "Dangerous";
          potable = false;
        }
      }
      // 🔴 Temperature خارج
      else {
        if (tds < 300 && turbidity <= 3) {
          status = "Caution";
        } else {
          status = "Dangerous";
          potable = false;
        }
      }
    }
    // 🟡 pH borderline
    else if (ph >= 6 && ph <= 9) {
      if (temperature > 35) {
        status = "Dangerous";
        potable = false;
      } else if (turbidity > 8) {
        status = "Dangerous";
        potable = false;
      } else if (tds > 700) {
        status = "Dangerous";
        potable = false;
      } else {
        status = "Caution";
      }
    }
    // 🔴 pH خارج خالص
    else {
      if (temperature > 35 || turbidity > 8 || tds > 700) {
        status = "Dangerous";
        potable = false;
      } else {
        status = "Caution";
      }
    }

    // ─────────────────────────────
    // 🧠 SCORE SYSTEM (متظبط)
    // ─────────────────────────────

    double score = 0;

    // pH
    if (ph >= 6.5 && ph <= 8.5)
      score += 25;
    else if (ph >= 6 && ph <= 9)
      score += 15;

    // Temperature
    if (temperature >= 22 && temperature <= 27) {
      score += 25;
    } else if (temperature >= 20 && temperature <= 30) {
      score += 20;
    } else if (temperature <= 33) {
      score += 18;
    } else {
      score += 10;
    }

    // TDS
    if (tds < 300)
      score += 25;
    else if (tds < 500)
      score += 18;
    else if (tds < 800)
      score += 8;

    // Turbidity (متقسمة صح 🔥)
    if (turbidity <= 1)
      score += 25;
    else if (turbidity <= 3)
      score += 20;
    else if (turbidity <= 5)
      score += 12;
    else if (turbidity <= 8)
      score += 6;
    else if (turbidity <= 10)
      score += 2;
    else
      score += 0;

    double confidence = score / 100;

    return {
      "status": status,
      "potable": potable,
      "score": score,
      "confidence": confidence,
    };
  }
}
