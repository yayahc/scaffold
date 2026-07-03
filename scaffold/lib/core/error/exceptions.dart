/// Low-level exceptions thrown inside the data layer (datasources).
/// Repositories catch these and map them to [Failure]s.
library;

class DatabaseException implements Exception {
  const DatabaseException([this.message = 'Database error']);
  final String message;

  @override
  String toString() => 'DatabaseException: $message';
}

class NotFoundException implements Exception {
  const NotFoundException([this.message = 'Not found']);
  final String message;

  @override
  String toString() => 'NotFoundException: $message';
}

class StorageException implements Exception {
  const StorageException([this.message = 'Local storage error']);
  final String message;

  @override
  String toString() => 'StorageException: $message';
}
