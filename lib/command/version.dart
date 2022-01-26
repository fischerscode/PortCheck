import 'package:args/command_runner.dart';
import 'package:version/version.dart';

class VersionCommand extends Command<int> {
  @override
  final name = 'version';
  @override
  final description = 'Print portcheck version.';

  static final Version version = Version(0, 0, 1);

  @override
  Future<int> run() async {
    print('PortCheck $version');
    return 0;
  }
}
