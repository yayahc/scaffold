import 'package:postgres/postgres.dart';

class PostgresClient {
  PostgresClient(this._databaseUrl);

  final String _databaseUrl;
  Connection? _connection;

  Future<Connection> get connection async {
    final existing = _connection;
    if (existing != null && existing.isOpen) return existing;

    final uri = Uri.parse(_databaseUrl);
    final endpoint = Endpoint(
      host: uri.host,
      port: uri.hasPort ? uri.port : 5432,
      database: uri.pathSegments.isNotEmpty ? uri.pathSegments.first : 'postgres',
      username: uri.userInfo.split(':').firstOrNull,
      password: uri.userInfo.contains(':') ? uri.userInfo.split(':').last : null,
    );

    return _connection = await Connection.open(
      endpoint,
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
  }

  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
