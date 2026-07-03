import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/config/env.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  await initDependencies();
  runApp(const ScaffoldApp());
}
