import 'dart:math';

import 'package:udp/udp.dart';
import 'package:collection/collection.dart';

class UDPClient {
  final UDP socket;
  final Endpoint server;
  late Future receiveFuture;

  UDPClient._({required this.server, required this.socket}) {
    final randomMessage = getRandMessage(10);
    receiveFuture = socket.asStream(timeout: Duration(seconds: 1)).firstWhere(
        (event) => ListEquality().equals(randomMessage, event?.data));
    socket.send(randomMessage, server);
  }

  static Future<UDPClient> connect(Endpoint server) async {
    return UDPClient._(server: server, socket: await UDP.bind(Endpoint.any()));
  }

  static List<int> getRandMessage(int len) {
    var random = Random.secure();
    return List<int>.generate(len, (i) => random.nextInt(255));
  }
}
