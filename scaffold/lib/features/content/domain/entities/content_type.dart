enum ContentType {
  quiz;

  static ContentType fromString(String value) {
    return ContentType.values.firstWhere(
      (t) => t.name == value,
      orElse: () => throw ArgumentError('Unknown content type: $value'),
    );
  }
}
