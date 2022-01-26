import 'dart:async';

import 'package:udp/udp.dart';

class UDPServer {
  final UDP _socket;
  late StreamSubscription streamSubscription;

  UDPServer._(this._socket) {
    streamSubscription = _socket.asStream().listen((data) {
      if (data != null) {
        _socket.send(
            data.data, Endpoint.unicast(data.address, port: Port(data.port)));
      }
    });
  }

  static Future<UDPServer> bind(
    Endpoint endpoint,
  ) async {
    final socket = await UDP.bind(endpoint);
    return UDPServer._(socket);
  }

  void dispose() {
    _socket.close();
  }
}
