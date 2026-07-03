part of 'content_list_cubit.dart';

enum ContentListStatus { initial, loading, success, failure }

class ContentListState extends Equatable {
  const ContentListState({
    this.status = ContentListStatus.initial,
    this.contents = const [],
    this.errorMessage,
  });

  final ContentListStatus status;
  final List<Content> contents;
  final String? errorMessage;

  ContentListState copyWith({
    ContentListStatus? status,
    List<Content>? contents,
    String? errorMessage,
  }) {
    return ContentListState(
      status: status ?? this.status,
      contents: contents ?? this.contents,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, contents, errorMessage];
}
