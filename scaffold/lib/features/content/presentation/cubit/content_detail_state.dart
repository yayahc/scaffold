part of 'content_detail_cubit.dart';

enum ContentDetailStatus { initial, loading, success, failure }

class ContentDetailState extends Equatable {
  const ContentDetailState({
    this.status = ContentDetailStatus.initial,
    this.content,
    this.unlocked = false,
    this.errorMessage,
  });

  final ContentDetailStatus status;
  final Content? content;
  final bool unlocked;
  final String? errorMessage;

  ContentDetailState copyWith({
    ContentDetailStatus? status,
    Content? content,
    bool? unlocked,
    String? errorMessage,
  }) {
    return ContentDetailState(
      status: status ?? this.status,
      content: content ?? this.content,
      unlocked: unlocked ?? this.unlocked,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, content, unlocked, errorMessage];
}
