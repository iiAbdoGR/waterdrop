class WaterQualityModel {
  static Map<String, dynamic> predict({
    required double ph,
    required double tds,
    required double temperature,
    required double turbidity,
  }) {
    // 🌳 Level 1: Critical (أخطر حاجة)
    if (turbidity >= 15) {
      return {"confidence": 0.1, "status": "Dangerous", "potable": false};
    }

    if (tds >= 1500) {
      return {"confidence": 0.15, "status": "Dangerous", "potable": false};
    }

    // 🌳 Level 2: Turbidity
    if (turbidity >= 10) {
      return {"confidence": 0.25, "status": "Dangerous", "potable": false};
    }

    // 🌳 Level 3: pH
    if (ph >= 6.5 && ph <= 8.5) {
      // 🌳 Level 4: TDS
      if (tds < 300) {
        // 🌳 Level 5: Temperature
        if (temperature >= 22 && temperature <= 27) {
          return {"confidence": 0.95, "status": "SAFE", "potable": true};
        } else if (temperature >= 20 && temperature <= 30) {
          return {"confidence": 0.85, "status": "SAFE", "potable": true};
        } else {
          return {"confidence": 0.7, "status": "Caution!", "potable": true};
        }
      } else if (tds < 700) {
        if (turbidity < 3) {
          return {"confidence": 0.75, "status": "Caution!", "potable": true};
        } else {
          return {"confidence": 0.6, "status": "Caution!", "potable": true};
        }
      } else if (tds < 1000) {
        return {"confidence": 0.5, "status": "Caution!", "potable": true};
      } else {
        return {"confidence": 0.3, "status": "Dangerous", "potable": false};
      }
    } else {
      // 🌳 Level 4: pH خارج الطبيعي
      if (ph < 6 || ph > 9) {
        return {"confidence": 0.2, "status": "Dangerous", "potable": false};
      }

      if (tds > 800 || turbidity > 5) {
        return {"confidence": 0.35, "status": "Dangerous", "potable": false};
      } else {
        return {"confidence": 0.55, "status": "Caution!", "potable": true};
      }
    }
  }
}
