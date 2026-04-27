import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ESPService {
  WebSocket? socket;

  Function(Map<String, dynamic>)? onData;
  Function(bool)? onConnectionChanged;

  Future<void> connect() async {
    await socket?.close();

    try {
      socket = await WebSocket.connect(
        'ws://192.168.4.1/ws',
      ).timeout(const Duration(seconds: 3));

      onConnectionChanged?.call(true);

      socket!.listen(
        (message) async {
          try {
            final data = jsonDecode(message);

            // 👇 ابعت الداتا للـ UI
            onData?.call(data);

            // 🔥 ارفع على Firebase
            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .collection('readings')
                  .add({
                    'temp': data['temp'],
                    'ph': data['ph'],
                    'tds': data['tds'],
                    'turbidity': data['turb'], // ⚠️ نفس الاسم اللي بتقرأه
                    'timestamp': FieldValue.serverTimestamp(),
                  });
            }
          } catch (e) {
            print("JSON Error: $e");
          }
        },
        onDone: () => onConnectionChanged?.call(false),
        onError: (_) => onConnectionChanged?.call(false),
      );
    } catch (e) {
      onConnectionChanged?.call(false);
    }
  }

  void disconnect() {
    socket?.close();
  }
}
