import 'dart:io';

import 'package:portcheck/command_runner.dart';

void main(List<String> arguments) async {
  var code = await PortCheckCommandRunner().run(arguments);
  await Future.wait([stdout.close(), stderr.close()]);
  exit(code);
}
