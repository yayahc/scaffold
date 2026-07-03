import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../progress/domain/entities/content_progress.dart';
import '../../../progress/domain/usecases/get_all_progress.dart';
import '../../domain/entities/content.dart';
import '../../domain/usecases/get_contents.dart';

part 'content_list_state.dart';

@injectable
class ContentListCubit extends Cubit<ContentListState> {
  ContentListCubit(this._getContents, this._getAllProgress)
    : super(const ContentListState());

  final GetContents _getContents;
  final GetAllProgress _getAllProgress;

  Future<void> load() async {
    emit(state.copyWith(status: ContentListStatus.loading));
    final result = await _getContents(const NoParams());
    await result.match(
      (failure) async => emit(
        state.copyWith(
          status: ContentListStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (contents) async {
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
      },
    );
  }
}
