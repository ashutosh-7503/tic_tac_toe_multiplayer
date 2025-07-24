import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;
  SocketClient.internal() {
    socket = IO.io('http://192.168.161.98:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Logging
    socket!.onConnect((_) {
      print('✅ Connected to server');
    });

    socket!.onConnectError((data) {
      print('❌ Connect Error: $data');
    });

    socket!.onError((data) {
      print('❌ General Error: $data');
    });

    socket!.onDisconnect((_) {
      print('⚠️ Disconnected from server');
    });

    socket!.connect();
  }
  static SocketClient get instance {
    _instance ??= SocketClient.internal();
    return _instance!;
  }
}
