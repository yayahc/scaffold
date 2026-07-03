import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/content_progress_model.dart';

/// Stores all progress as a single JSON object under one key. The whole map is
/// read, mutated, and written back — fine for the small data volume here.
abstract interface class ProgressLocalDataSource {
  Future<Map<String, ContentProgressModel>> readAll();
  Future<void> write(ContentProgressModel progress);
}

@LazySingleton(as: ProgressLocalDataSource)
class ProgressLocalDataSourceImpl implements ProgressLocalDataSource {
  ProgressLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'content_progress';

  @override
  Future<Map<String, ContentProgressModel>> readAll() async {
    try {
      final raw = _prefs.getString(_key);
      if (raw == null || raw.isEmpty) return {};
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map(
        (id, json) => MapEntry(
          id,
          ContentProgressModel.fromJson(id, json as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<void> write(ContentProgressModel progress) async {
    try {
      final all = await readAll();
      all[progress.contentId] = progress;
      final encoded = jsonEncode(
        all.map((id, model) => MapEntry(id, model.toJson())),
      );
      await _prefs.setString(_key, encoded);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
