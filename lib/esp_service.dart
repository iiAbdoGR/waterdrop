import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class ESPService {
  final _channel = WebSocketChannel.connect(Uri.parse('ws://192.168.X.X:81'));

  Stream<Map<String, dynamic>> get stream {
    return _channel.stream.map((data) {
      return jsonDecode(data);
    });
  }

  void dispose() {
    _channel.sink.close();
  }
}
