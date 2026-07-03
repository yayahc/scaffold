part of 'content_list_cubit.dart';

enum ContentListStatus { initial, loading, success, failure }

class ContentListState extends Equatable {
  const ContentListState({
    this.status = ContentListStatus.initial,
    this.contents = const [],
    this.progress = const {},
    this.errorMessage,
  });

  final ContentListStatus status;
  final List<Content> contents;

  /// Progress keyed by content id, for badging the list.
  final Map<String, ContentProgress> progress;
  final String? errorMessage;

  ContentListState copyWith({
    ContentListStatus? status,
    List<Content>? contents,
    Map<String, ContentProgress>? progress,
    String? errorMessage,
  }) {
    return ContentListState(
      status: status ?? this.status,
      contents: contents ?? this.contents,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, contents, progress, errorMessage];
}
