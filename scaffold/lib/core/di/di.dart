import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/env.dart';
import '../database/postgres_client.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() => getIt.init();

/// Provides dependencies that can't be constructed by annotation alone:
/// async singletons and ones needing runtime values (the DB URL from .env).
@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  PostgresClient postgresClient() => PostgresClient(Env.databaseUrl);
}
