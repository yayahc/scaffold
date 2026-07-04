import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../progress/domain/entities/content_progress.dart';
import '../../../progress/domain/usecases/get_all_progress.dart';
import '../../domain/entities/content.dart';
import '../../domain/usecases/get_contents.dart';
import '../../domain/usecases/refresh_contents.dart';

part 'content_list_state.dart';

@injectable
class ContentListCubit extends Cubit<ContentListState> {
  ContentListCubit(
    this._refreshContents,
    this._getContents,
    this._getAllProgress,
  ) : super(const ContentListState());

  final RefreshContents _refreshContents;
  final GetContents _getContents;
  final GetAllProgress _getAllProgress;

  /// Initial load for the main screen: pull fresh content from the backend,
  /// falling back to any cached content if the network is unavailable.
  Future<void> load() async {
    emit(state.copyWith(status: ContentListStatus.loading));
    final result = await _refreshContents(const NoParams());
    await result.match(
      (_) async {
        // Remote refresh failed — try to show cached content instead.
        final cached = await _getContents(const NoParams());
        await cached.match(
          (failure) async => emit(
            state.copyWith(
              status: ContentListStatus.failure,
              errorMessage: failure.message,
            ),
          ),
          _emitSuccess,
        );
      },
      _emitSuccess,
    );
  }

  /// Lightweight reload used when returning to the list (e.g. after finishing a
  /// quiz): refreshes progress badges from the cache without a network round-trip.
  Future<void> reload() async {
    final result = await _getContents(const NoParams());
    await result.match(
      (failure) async => emit(
        state.copyWith(
          status: ContentListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      _emitSuccess,
    );
  }

  Future<void> _emitSuccess(List<Content> contents) async {
    final progress = (await _getAllProgress(
      const NoParams(),
    )).getOrElse((_) => const {});
    emit(
      state.copyWith(
        status: ContentListStatus.success,
        contents: contents,
        progress: progress,
      ),
    );
  }
}
