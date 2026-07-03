import 'package:postgres/postgres.dart';

import '../../../../core/database/postgres_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/content_model.dart';

abstract interface class ContentRemoteDataSource {
  Future<List<ContentModel>> getContents();
  Future<ContentModel> getContentById(String id);
}

class ContentRemoteDataSourceImpl implements ContentRemoteDataSource {
  ContentRemoteDataSourceImpl(this._client);

  final PostgresClient _client;

  @override
  Future<List<ContentModel>> getContents() async {
    try {
      final conn = await _client.connection;
      final result = await conn.execute(
        Sql.named('''
          SELECT id, type, title, description, cover_image, published,
                 locked, unlock_code, '{}'::jsonb AS payload,
                 created_at, updated_at
          FROM content
          WHERE published = true
          ORDER BY created_at DESC
        '''),
      );
      return result
          .map((row) => ContentModel.fromRow(row.toColumnMap()))
          .toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<ContentModel> getContentById(String id) async {
    try {
      final conn = await _client.connection;
      final result = await conn.execute(
        Sql.named('SELECT * FROM content WHERE id = @id'),
        parameters: {'id': id},
      );
      if (result.isEmpty) {
        throw NotFoundException('No content with id $id');
      }
      return ContentModel.fromRow(result.first.toColumnMap());
    } on NotFoundException {
      rethrow;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
