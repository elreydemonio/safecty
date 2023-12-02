import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

import 'app.dart';
import 'bootstrapper.dart';
import 'flavor.dart';

Future<void> launchApp({required Flavor flavor}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: always_specify_types
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(
    App(bootstrapper: Bootstrapper.fromFlavor(flavor)),
  );
}
