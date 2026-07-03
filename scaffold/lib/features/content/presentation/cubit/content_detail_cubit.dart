import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/content.dart';
import '../../domain/usecases/get_content_by_id.dart';

part 'content_detail_state.dart';

class ContentDetailCubit extends Cubit<ContentDetailState> {
  ContentDetailCubit(this._getContentById) : super(const ContentDetailState());

  final GetContentById _getContentById;

  Future<void> load(String id) async {
    emit(state.copyWith(status: ContentDetailStatus.loading));
    final result = await _getContentById(id);
    result.match(
      (failure) => emit(state.copyWith(
        status: ContentDetailStatus.failure,
        errorMessage: failure.message,
      )),
      (content) => emit(state.copyWith(
        status: ContentDetailStatus.success,
        content: content,
        unlocked: !content.locked,
      )),
    );
  }

  bool tryUnlock(String code) {
    final content = state.content;
    if (content == null) return false;
    final ok = code.trim() == content.unlockCode;
    if (ok) emit(state.copyWith(unlocked: true));
    return ok;
  }
}
