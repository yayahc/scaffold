import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../progress/domain/usecases/get_content_progress.dart';
import '../../../progress/domain/usecases/unlock_content.dart';
import '../../domain/entities/content.dart';
import '../../domain/usecases/get_content_by_id.dart';

part 'content_detail_state.dart';

class ContentDetailCubit extends Cubit<ContentDetailState> {
  ContentDetailCubit(
    this._getContentById,
    this._getContentProgress,
    this._unlockContent,
  ) : super(const ContentDetailState());

  final GetContentById _getContentById;
  final GetContentProgress _getContentProgress;
  final UnlockContent _unlockContent;

  Future<void> load(String id) async {
    emit(state.copyWith(status: ContentDetailStatus.loading));
    final result = await _getContentById(id);
    await result.match(
      (failure) async => emit(
        state.copyWith(
          status: ContentDetailStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (content) async {
        // Unlocked if it isn't locked, or was unlocked on a previous visit.
        final progress = (await _getContentProgress(id)).toNullable();
        emit(
          state.copyWith(
            status: ContentDetailStatus.success,
            content: content,
            unlocked: !content.locked || (progress?.unlocked ?? false),
          ),
        );
      },
    );
  }

  bool tryUnlock(String code) {
    final content = state.content;
    if (content == null) return false;
    final ok = code.trim() == content.unlockCode;
    if (ok) {
      emit(state.copyWith(unlocked: true));
      // Persist so it stays unlocked next time; fire-and-forget.
      unawaited(_unlockContent(content.id));
    }
    return ok;
  }
}
