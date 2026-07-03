import 'package:postgres/postgres.dart';

class PostgresClient {
  PostgresClient(this._databaseUrl);

  final String _databaseUrl;
  Connection? _connection;

  Future<Connection> get connection async {
    return await Connection.openFromUrl(
      _databaseUrl,
    );  
  }

  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
