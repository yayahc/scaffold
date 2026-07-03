abstract final class Env {
  static const String _databaseUrl = String.fromEnvironment('DATABASE_URL');

  static String get databaseUrl {
    if (_databaseUrl.isEmpty) {
      throw StateError(
        'DATABASE_URL is missing. Pass it via '
        '--dart-define-from-file=dart_define.json (see dart_define.example.json).',
      );
    }
    return _databaseUrl;
  }
}
