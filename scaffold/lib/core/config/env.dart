import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class Env {
  static Future<void> load() => dotenv.load(fileName: '.env');

  static String get databaseUrl {
    final url = dotenv.env['DATABASE_URL'];
    if (url == null || url.isEmpty) {
      throw StateError('DATABASE_URL is missing from .env');
    }
    return url;
  }
}
