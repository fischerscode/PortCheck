import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:portcheck/command/client.dart';
import 'package:portcheck/command/server.dart';
import 'package:portcheck/command/version.dart';

class PortCheckCommandRunner extends CommandRunner<int> {
  PortCheckCommandRunner()
      : super(
          'portcheck',
          'A tool that helps you to keep your repository up to date.',
        ) {
    addCommand(ClientCommand());
    addCommand(ServerCommand());
    addCommand(VersionCommand());
    argParser.addOption(
      'protocol',
      help: 'The protocol',
      allowed: ["tcp", "udp"],
      defaultsTo: "tcp",
      aliases: ["proto"],
      allowedHelp: {
        'tcp': 'Use TCP.',
        'udp': 'Use UDP.',
      },
    );
  }

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      return await super.run(args) ?? 0;
    } on UsageException catch (e) {
      stderr.writeln(e);
      return 1;
    }
  }
}
