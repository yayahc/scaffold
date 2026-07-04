import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/content_model.dart';

abstract interface class ContentLocalDataSource {
  Future<List<ContentModel>?> readContents();
  Future<void> writeContents(List<ContentModel> contents);
  Future<void> clear();
}

@LazySingleton(as: ContentLocalDataSource)
class ContentLocalDataSourceImpl implements ContentLocalDataSource {
  ContentLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'cached_contents';

  @override
  Future<List<ContentModel>?> readContents() async {
    try {
      final raw = _prefs.getString(_key);
      if (raw == null || raw.isEmpty) return null;
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<void> writeContents(List<ContentModel> contents) async {
    try {
      final encoded = jsonEncode(contents.map((c) => c.toJson()).toList());
      await _prefs.setString(_key, encoded);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<void> clear() => _prefs.remove(_key);
}
