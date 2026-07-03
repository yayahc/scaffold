import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/content.dart';
import '../../domain/usecases/get_contents.dart';

part 'content_list_state.dart';

class ContentListCubit extends Cubit<ContentListState> {
  ContentListCubit(this._getContents) : super(const ContentListState());

  final GetContents _getContents;

  Future<void> load() async {
    emit(state.copyWith(status: ContentListStatus.loading));
    final result = await _getContents(const NoParams());
    result.match(
      (failure) => emit(state.copyWith(
        status: ContentListStatus.failure,
        errorMessage: failure.message,
      )),
      (contents) => emit(state.copyWith(
        status: ContentListStatus.success,
        contents: contents,
      )),
    );
  }
}
