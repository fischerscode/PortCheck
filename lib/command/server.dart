import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:portcheck/udpserver.dart';
import 'package:udp/udp.dart';

class ServerCommand extends Command<int> {
  @override
  final name = 'server';
  @override
  final description = 'Run the portcheck server.';

  ServerCommand() {
    argParser
      ..addOption(
        'address',
        abbr: 'a',
        help: 'The address the server binds to.',
      )
      ..addMultiOption(
        'ports',
        abbr: 'p',
        help: 'The ports the server binds to.',
        splitCommas: true,
        defaultsTo: ["12345"],
      );
  }

  @override
  Future<int> run() async {
    String protocol = globalResults?['protocol'];

    String? address = argResults?["address"];
    List<String> ports = argResults?["ports"];

    switch (protocol) {
      case "udp":
        for (var port in ports) {
          await UDPServer.bind(address == null
              ? Endpoint.any(port: Port(int.parse(port)))
              : Endpoint.unicast(InternetAddress.tryParse(address),
                  port: Port(int.parse(port))));
          print("Server started on port $port");
        }
        break;
      default:
        print("Protocol $protocol not implemented!");
        return 1;
    }

    while (true) {
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
