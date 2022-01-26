import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:portcheck/udpclient.dart';
import 'package:udp/udp.dart';

class ClientCommand extends Command<int> {
  @override
  final name = 'client';
  @override
  final description = 'Check ports as a client.';

  ClientCommand() {
    argParser
      ..addOption(
        'address',
        abbr: 'a',
        help: 'The server address.',
        mandatory: true,
      )
      ..addOption(
        'port',
        abbr: 'p',
        help: 'The server port.',
        mandatory: true,
      );
  }

  @override
  Future<int> run() async {
    String protocol = globalResults?['protocol'];

    String address = argResults?["address"];
    String port = argResults?["port"];

    switch (protocol) {
      case "udp":
        final client = await UDPClient.connect(Endpoint.unicast(
            InternetAddress.tryParse(address),
            port: Port(int.parse(port))));
        try {
          await client.receiveFuture;
          print("Server reachable!");
          return 0;
        } on StateError catch (e) {
          if (e.message == "No element") {
            print("Server unreachable!");
            return 1;
          }
        }
        break;
      default:
        print("Protocol $protocol not implemented!");
    }

    return 1;
  }
}
